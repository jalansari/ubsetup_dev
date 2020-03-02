function runPrintBinValTest()
{   valueToTest=$(( $1 ))
    resultExpected=$(( $2 ))
    printValExpected="$3"
    ret=$( removeLeastSignificantBit $valueToTest )
    testPrintOut=$( printBinaryVal $valueToTest )
    assertEquals "Got: $( printBinaryVal $ret )" $resultExpected $ret
    assertEquals "$printValExpected" "$testPrintOut"
}

function test_printBinaryVal_zero()
{   binvalue=2#00000000
    expected=2#00000000
    expPrint=$( echo -e "Bin: 0b0\nHex: 0x00000000\nOct: 0o00000000000" )
    runPrintBinValTest $binvalue $expected "$expPrint"
}

function test_printBinaryVal_one()
{   binvalue=2#00000001
    expected=2#00000000
    expPrint=$( echo -e "Bin: 0b1\nHex: 0x00000001\nOct: 0o00000000001" )
    runPrintBinValTest $binvalue $expected "$expPrint"
}

function test_printBinaryVal_five()
{   binvalue=2#00000101
    expected=2#00000100
    expPrint=$( echo -e "Bin: 0b101\nHex: 0x00000005\nOct: 0o00000000005" )
    runPrintBinValTest $binvalue $expected "$expPrint"
}

function test_printBinaryVal_singleBitInMiddle()
{   binvalue=2#00100000
    expected=2#00000000
    expPrint=$( echo -e "Bin: 0b100000\nHex: 0x00000020\nOct: 0o00000000040" )
    runPrintBinValTest $binvalue $expected "$expPrint"
}

function test_printBinaryVal_twoBitsInMiddle()
{   binvalue=2#00101000
    expected=2#00100000
    expPrint=$( echo -e "Bin: 0b101000\nHex: 0x00000028\nOct: 0o00000000050" )
    runPrintBinValTest $binvalue $expected "$expPrint"
}

function test_printBinaryVal_arbitraryNumbers()
{   binvalue=15680
    expected=15616
    expPrint=$( echo -e "Bin: 0b11110101000000\nHex: 0x00003D40\nOct: 0o00000036500" )
    runPrintBinValTest $binvalue $expected "$expPrint"

    binvalue=2#0010000000101100
    expected=2#0010000000101000
    expPrint=$( echo -e "Bin: 0b10000000101100\nHex: 0x0000202C\nOct: 0o00000020054" )
    runPrintBinValTest $binvalue $expected "$expPrint"

    binvalue=0x156fe
    expected=0x156fc
    expPrint=$( echo -e "Bin: 0b10101011011111110\nHex: 0x000156FE\nOct: 0o00000253376" )
    runPrintBinValTest $binvalue $expected "$expPrint"
}

function test_printBinaryVal_biggestNumbers()
{   binvalue=2#11111111111111111111111111111111
    expected=2#11111111111111111111111111111110
    expPrint=$( echo -e "Bin: 0b11111111111111111111111111111111\nHex: 0xFFFFFFFF\nOct: 0o37777777777" )
    runPrintBinValTest $binvalue $expected "$expPrint"

    binvalue=2#10000000000000000000000000000000
    expected=2#00000000000000000000000000000000
    expPrint=$( echo -e "Bin: 0b10000000000000000000000000000000\nHex: 0x80000000\nOct: 0o20000000000" )
    runPrintBinValTest $binvalue $expected "$expPrint"

    binvalue=2#11000000000000000000000000000000
    expected=2#10000000000000000000000000000000
    expPrint=$( echo -e "Bin: 0b11000000000000000000000000000000\nHex: 0xC0000000\nOct: 0o30000000000" )
    runPrintBinValTest $binvalue $expected "$expPrint"
}

################################################################################

function test_checkDebPkgInstalled_noSuchPackageReturnsNonZero()
{   checkDebPkgInstalled "noSuchPackage" > /dev/null 2>&1
    ret=$?
    assertNotEquals 0 $ret
}

function test_checkDebPkgInstalled_installedPackageReturnsZero()
{   checkDebPkgInstalled "bash" > /dev/null 2>&1 # Bash must exist for this script to be executing!
    ret=$?
    assertEquals 0 $ret
}

################################################################################

newFileNameGenerated=""
function runGetAvailableFNTest()
{   req=$1
    exp=$2
    ret=$( getAvailableFileName "$req" )
    newFileNameGenerated=$ret
    assertEquals "$exp" "$ret"
}

function del3Files()
{   rm "$1" "$2" "$3" > /dev/null 2>&1
}

function test_getAvailableFN_emptyString()
{   requestName=""
    expected=""
    runGetAvailableFNTest "$requestName" "$expected"
}

function test_getAvailableFN_noFileExists()
{   requestName="someFile"
    expected="someFile"
    del3Files "$requestName" "$expected"
    runGetAvailableFNTest "$requestName" "$expected"
}

function test_getAvailableFN_nameWithSpaceNotExists()
{   requestName="some File"
    expected="some File"
    del3Files "$requestName" "$expected"
    runGetAvailableFNTest "$requestName" "$expected"
}

function test_getAvailableFN_nameWithSpace()
{   requestName="some File"
    expected="some File.1"
    del3Files "$requestName" "$expected"
    touch "$requestName"
    runGetAvailableFNTest "$requestName" "$expected"
    del3Files "$requestName" "$expected"
}

function test_getAvailableFN_fileExists()
{   requestName="someFile"
    expected="someFile.1"
    del3Files "$requestName" "$expected"
    touch $requestName
    runGetAvailableFNTest "$requestName" "$expected"
    del3Files "$requestName" "$expected"
}

function test_getAvailableFN_fileExistsX3()
{   requestName="someFile"
    expected0="someFile.1"
    expected1="someFile.2"
    expected2="someFile.3"
    del3Files "$requestName" "$newName0"
    del3Files "$newName1" "$newName2"

    touch "$requestName"
    runGetAvailableFNTest "$requestName" "$expected0"
    newName0=$newFileNameGenerated

    touch "$newName0"
    runGetAvailableFNTest "$requestName" "$expected1"
    newName1=$newFileNameGenerated

    touch "$newName1"
    runGetAvailableFNTest "$requestName" "$expected2"

    assertTrue "File does NOT exist!" '[ -e "$requestName" ]'
    assertTrue "File does NOT exist!" '[ -e "$newName0" ]'
    assertTrue "File does NOT exist!" '[ -e "$newName1" ]'
    del3Files "$requestName" "$newName0" "$newName1"
    assertFalse "File <$requestName> STILL exists!" '[ -e "$requestName" ]'
    assertFalse "File <$newName0> STILL exists!" '[ -e "$newName0" ]'
    assertFalse "File <$newName1> STILL exists!" '[ -e "$newName1" ]'
}

################################################################################

function runUpdatePathTest()
{   updatePathInFile $1 $2
    ret=$?
    assertEquals $3 $ret
}

function grepForStr()
{   searchStr="$1"
    searchFile=$2
    grepExpectedRet=$3
    grep "$searchStr" $searchFile > /dev/null 2>&1
    testRet=$?
    fileContent="$( cat $searchFile )"
    assertEquals "===== Expected to Find: <$searchStr> ===== File Content: <$fileContent>" $grepExpectedRet $testRet
}

function grepForStrAndDelFile()
{   searchFile=$2
    grepForStr "$1" $searchFile $3
    rm $searchFile
}

function test_updatePathInFile_updatePathWithAdditionalValue()
{   testfile="profiletestfile"
    additionalValue="\$NewPath/sub"
    expectedRet=0
    echo -e "text\n\n  PATH=sometext:\$PATH\nmore" > $testfile

    runUpdatePathTest $additionalValue $testfile $expectedRet

    grepForStrAndDelFile "^  PATH=sometext:\$PATH:$additionalValue:$" "$testfile" 0
}

function test_updatePathInFile_noPathUpdateValueAlreadyExists()
{   testfile="profiletestfile"
    additionalValue="\$NewPath"
    expectedRet=0
    echo -e "text\n\n  PATH=sometext:\$PATH:$additionalValue:more\nevenmore" > $testfile

    runUpdatePathTest "$additionalValue" $testfile $expectedRet

    grepForStrAndDelFile "^  PATH=sometext:\$PATH:$additionalValue:more$" $testfile 0
}

function test_updatePathInFile_addPathToFile()
{   testfile="profiletestfile"
    additionalValue="\$NewPath/somepath"
    expectedRet=0
    echo -e "text\n\nevenmore" > $testfile

    runUpdatePathTest $additionalValue $testfile $expectedRet

    grepForStrAndDelFile "^PATH=\$PATH:$additionalValue$" "$testfile" 0
}

function test_updatePathInFile_fileDoesNotExistRet9()
{   testfile="profiletestfile"
    rm $testfile > /dev/null 2>&1
    additionalValue="\$NewPath"
    expectedRet=9

    runUpdatePathTest $additionalValue $testfile $expectedRet
}

function test_updatePathInFile_fileIsActuallyDirRet9()
{   testfile="profiletestfile"
    rm -rf $testfile > /dev/null 2>&1
    mkdir -p $testfile
    additionalValue="\$NewPath"
    expectedRet=9

    runUpdatePathTest $additionalValue $testfile $expectedRet
    rm -rf $testfile
}

################################################################################

function runRemoveFromPathTest()
{   removeFromPath "$1" "$2"
    ret=$?
    assertEquals $3 $ret
}

function test_removeFromPath_fileDoesNotExistRet1()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    removeText="\$NewPath"
    expectedRet=9

    runRemoveFromPathTest "$removeText" $testfile $expectedRet
}

function test_removeFromPath_fileIsActuallyDirRet1()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    mkdir -p $testfile
    removeText="\$NewPath"
    expectedRet=9

    runRemoveFromPathTest "$removeText" $testfile $expectedRet
    rm -rf $testfile
}

function test_removeFromPath_emptyInput()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    removeText=""
    expectedRet=8
    echo -e "text\n\n  PATH=sometext:\$PATH::more\nevenmore" > $testfile

    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet

    grepForStrAndDelFile "^  PATH=sometext:\$PATH::more$" "$testfile" 0
}

function test_removeFromPath_stringNotExists()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    removeText="/somepath/not/exists"
    expectedRet=0
    echo -e "text\n\n  PATH=sometext:\$PATH::more\nevenmore" > $testfile

    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet

    grepForStrAndDelFile "^  PATH=sometext:\$PATH::more$" "$testfile" 0
}

function test_removeFromPath_stringAlmostExists()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    removeText="/somepath/exists"
    expectedRet=0
    echo -e "text\n\n  PATH=sometext:/somepath/exists/butnotquite:\$PATH::more\nevenmore" > $testfile

    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet

    grepForStrAndDelFile "^  PATH=sometext:/somepath/exists/butnotquite:\$PATH::more$" "$testfile" 0
}

function test_removeFromPath_stringExists()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    removeText="/somepath/exists"
    expectedRet=0
    echo -e "text\n\n  PATH=sometext:/somepath/exists:\$PATH::more\nevenmore" > $testfile

    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet

    grepForStrAndDelFile "^  PATH=sometext:\$PATH::more$" "$testfile" 0
}

function test_removeFromPath_stringWithDollarSignDoesNotExists()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    removeText="\$APREFIX/somepath/exists"
    expectedRet=0
    echo -e "text\n\n  PATH=sometext:/somepath/exists:\$PATH::more\nevenmore" > $testfile

    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet

    grepForStrAndDelFile "^  PATH=sometext:/somepath/exists:\$PATH::more$" "$testfile" 0
}

function test_removeFromPath_stringWithDollarSignExists()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    removeText="\$APREFIX/somepath/exists"
    expectedRet=0
    echo -e "text\n\n  PATH=sometext:\$APREFIX/somepath/exists:\$PATH::more\nevenmore" > $testfile

    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet

    grepForStrAndDelFile "^  PATH=sometext:\$PATH::more$" "$testfile" 0
}

function test_removeFromPath_stringExistsAsTwoAlmostSameInstances()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    removeText="/somepath/exists"
    expectedRet=0

    echo -e "text\n\n  PATH=sometext:/somepath/exists:\$PATH::/somepath/exists/withextra:more\nevenmore" > $testfile
    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet
    grepForStrAndDelFile "^  PATH=sometext:\$PATH::/somepath/exists/withextra:more$" "$testfile" 0

    echo -e "text\n\n  PATH=sometext:/somepath/exists:\$PATH::\$ANOTHERPATH/somepath/exists:more\nevenmore" > $testfile
    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet
    grepForStrAndDelFile "^  PATH=sometext:\$PATH::\$ANOTHERPATH/somepath/exists:more$" "$testfile" 0
}

function test_removeFromPath_stringExistsAsTwoExactInstances()
{   testfile="removefrompathtestfile"
    rm -rf $testfile > /dev/null 2>&1
    removeText="/some path/exists"
    expectedRet=0

    echo -e "text\n PATH=sometext:/some path/exi\n\n  PATH=sometext:/some path/exists:\$PATH::/some path/exists:more\nevenmore" > $testfile
    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet
    grepForStr "^  PATH=sometext:\$PATH::more$" "$testfile" 0
    grepForStrAndDelFile "^ PATH=sometext:/some path/exi$" "$testfile" 0

    echo -e "text\nsometext:/some path/exits\n\n  PATH=sometext:/some path/exists:\$PATH::/some path/exists\nevenmore" > $testfile
    runRemoveFromPathTest "$removeText" "$testfile" $expectedRet
    grepForStr "^  PATH=sometext:\$PATH::$" "$testfile" 0
    grepForStrAndDelFile "^sometext:/some path/exits$" "$testfile" 0
}

################################################################################

iterAssociativeArrAndCallTestCaptureNum=0
iterAssociativeArrAndCallTestCaptureStr=""
function iterAssociativeArrAndCallReset()
{   iterAssociativeArrAndCallTestCaptureNum=0
    iterAssociativeArrAndCallTestCaptureStr=""
}
function TestCallBack_iterAA()
{   iterAssociativeArrAndCallTestCaptureStr+="$1;$2;"
    iterAssociativeArrAndCallTestCaptureNum=$(( $iterAssociativeArrAndCallTestCaptureNum+1 ))
}

function test_iterAssociativeArrAndCall_invalidInputAsArray()
{   testarray="not an array"
    iterAssociativeArrAndCallReset
    iterAssociativeArrAndCall "$testarray" TestCallBack_iterAA
    returnedVal=$?

    expectedReturn=1
    assertEquals $expectedReturn $returnedVal

    expNumCalls=0
    expStr=""
    assertEquals "$expNumCalls" "$iterAssociativeArrAndCallTestCaptureNum"
    assertEquals "$expStr" "$iterAssociativeArrAndCallTestCaptureStr"
}

function test_iterAssociativeArrAndCall_undefinedArray()
{   declare -A testarray
    iterAssociativeArrAndCallReset
    iterAssociativeArrAndCall "declare -A testarray" TestCallBack_iterAA > /dev/null

    expNumCalls=0
    expStr=""
    assertEquals "$expNumCalls" "$iterAssociativeArrAndCallTestCaptureNum"
    assertEquals "$expStr" "$iterAssociativeArrAndCallTestCaptureStr"
}

function test_iterAssociativeArrAndCall_emptyArray()
{   declare -A testarray
    testarray=(
              )
    iterAssociativeArrAndCallReset
    iterAssociativeArrAndCall "$(declare -p testarray)" TestCallBack_iterAA > /dev/null

    expNumCalls=0
    expStr=""
    assertEquals "$expNumCalls" "$iterAssociativeArrAndCallTestCaptureNum"
    assertEquals "$expStr" "$iterAssociativeArrAndCallTestCaptureStr"
}

function test_iterAssociativeArrAndCall_oneValArray()
{   declare -A testarray
    testarray=(
               ["key1"]="value"
              )
    iterAssociativeArrAndCallReset
    iterAssociativeArrAndCall "$(declare -p testarray)" TestCallBack_iterAA > /dev/null

    expNumCalls=1
    expStr="key1;value;"
    assertEquals "$expNumCalls" "$iterAssociativeArrAndCallTestCaptureNum"
    assertEquals "$expStr" "$iterAssociativeArrAndCallTestCaptureStr"
}

function test_iterAssociativeArrAndCall_manyValArray()
{   declare -A testarray
    testarray=(
               ["key1"]="value"
               ["key2"]="value2"
               ["key 3"]="value 3"
               ["ab cd"]="value abcd"
              )
    iterAssociativeArrAndCallReset
    iterAssociativeArrAndCall "$(declare -p testarray)" TestCallBack_iterAA > /dev/null

    expNumCalls=4
    # expStr="key1;value;key2;value2;key 3;value 3;ab cd;value abcd;" # TODO expected string will not be in a predictable order.
    assertEquals "$expNumCalls" "$iterAssociativeArrAndCallTestCaptureNum"
}

################################################################################

function test_addNewUser_NoUsername()
{   usernameToAdd=""
    groupName=""
    expected=1

    addNewUser $usernameToAdd "$groupName" ""
    actualReturn=$?

    assertEquals $expected $actualReturn
}

function test_addNewUser_UsernameAlreadyExists()
{   userOfThisScript=$( id -u -n $SUDO_USER )
    usernameToAdd=$userOfThisScript
    groupName=""
    expected=2

    addNewUser $usernameToAdd "$groupName" ""
    actualReturn=$?

    assertEquals $expected $actualReturn
    # Test user details have not changed.
}

function test_addNewUser_NoGroup()
{   userOfThisScript=$( id -u -n $SUDO_USER )
    usernameToAdd="$userOfThisScript.testuserNoGroup"
    groupName=""
    expected=3

    addNewUser $usernameToAdd "$groupName" ""
    actualReturn=$?

    assertEquals $expected $actualReturn
    id -u $usernameToAdd > /dev/null 2>&1
    assertFalse "Test user must not be created" '[ $? == 0 ]'
}

function test_addNewUser_BadGECOS()
{   userOfThisScript=$( id -u -n $SUDO_USER )
    usernameToAdd="$userOfThisScript.testuserBadGecos"
    groupName="testgroup"
    fullName="This:Name:Should:Be:Bad: for:GECOS"
    expected=9

    addNewUser $usernameToAdd "$groupName" "$fullName"
    actualReturn=$?

    assertEquals $expected $actualReturn
    id -u $usernameToAdd > /dev/null 2>&1
    assertFalse "Test user must not be created" '[ $? == 0 ]'
}

# function test_addNewUser_BadGroupName()
# {
# }

# function test_addNewUser_ExistingGroupName()
# {
# }

# function test_addNewUser_NewGroupName()
# {
# }

function test_updateExistingUser_NoUsername()
{   usernameToAdd=""
    groupName=""
    expected=1

    updateExistingUser $usernameToAdd "$groupName" ""
    actualReturn=$?

    assertEquals $expected $actualReturn
}

function test_updateExistingUser_UsernameDoesNotExists()
{   userOfThisScript=$( id -u -n $SUDO_USER )
    usernameToAdd="$userOfThisScript.testuserNotExist"
    groupName=""
    expected=2

    updateExistingUser $usernameToAdd "$groupName" ""
    actualReturn=$?

    assertEquals $expected $actualReturn
}

function test_updateExistingUser_BadGECOS()
{   userOfThisScript=$( id -u -n $SUDO_USER )
    usernameToAdd=$userOfThisScript
    groupName=""
    fullName="This:Name:Should:Be:Bad: for:GECOS"
    expected=9

    updateExistingUser $usernameToAdd "$groupName" "$fullName"
    actualReturn=$?

    assertEquals $expected $actualReturn
    # Test user details have not changed.
}

function test_updateExistingUser_BadGroupName()
{   userOfThisScript=$( id -u -n $SUDO_USER )
    usernameToAdd=$userOfThisScript
    groupName="bad:group:name"
    expected=8

    updateExistingUser $usernameToAdd "$groupName" ""
    actualReturn=$?

    assertEquals $expected $actualReturn
    # Test user details have not changed.
}

# function test_updateExistingUser_ExistingGroupName()
# {
# }

# function test_updateExistingUser_NewGroupName()
# {
# }

################################################################################

function test_wgetAndUnpack_emptyStrReturns2()
{   emptystr=""
    expected=2
    wgetAndUnpack $emptystr
    returnedVal=$?
    assertEquals $expected $returnedVal
    wgetAndUnpack "url" $emptystr
    returnedVal=$?
    assertEquals $expected $returnedVal
    wgetAndUnpack "url" "pkgname" $emptystr
    returnedVal=$?
    assertEquals $expected $returnedVal
}

function test_wgetAndUnpack_testFileOrDirExitstsReturns1()
{   testfileordir="wgetandunpacktest"
    expected=1
    rm -rf $testfileordir
    touch $testfileordir
    wgetAndUnpack "url" "pkgname" "unpackpath" $testfileordir > /dev/null
    returnedVal=$?
    assertEquals $expected $returnedVal
    rm $testfileordir
    mkdir $testfileordir
    wgetAndUnpack "url" "pkgname" "unpackpath" $testfileordir > /dev/null
    returnedVal=$?
    assertEquals $expected $returnedVal
    rm -rf $testfileordir
}

# With test server

TestServerDomain="http://localhost:8000"
TestServerPID=""
TestServerFolder="ubsetup_testserver_folder"
WgetToDir="unpackpath"

function runTestServer()
{   mkdir -p $TestServerFolder
    cd $TestServerFolder
        python3 -m http.server > /dev/null &
        TestServerPID=$!
        psstatcmd="ps -o stat= $TestServerPID"
        psstate=$( $psstatcmd )
        # Wait untill process state is ready and waiting ("S") or could not be started (no state).
        while [[ ! $psstate =~ ^S ]] && [[ ! -z $psstate ]]
        do
            # Waiting a little to allow state to initialise.
            sleep 0.01
            psstate=$( $psstatcmd )
        done
        assertFalse "Test Server could not be launched" "[ -z $psstate ]"
        # A small Wait to make sure process is definitely initialised.
        sleep 0.2
    cd - > /dev/null
}

function cleanupAfterTestServerTesting()
{   kill $TestServerPID
    rm -rf $TestServerFolder
    rm -rf $WgetToDir
}

function test_wgetAndUnpack_testGetInvalidUrl()
{   runTestServer

    expected=3

    wgetAndUnpack "$TestServerDomain/InvalidUrl" "invalidUrlPckgDoesntMatter" "$WgetToDir" "pathDoesntMatter" > /dev/null 2>&1

    returnedVal=$?
    assertEquals $expected $returnedVal

    cleanupAfterTestServerTesting
}

function test_wgetAndUnpack_testGetEmptyFile()
{   runTestServer

    aFileName="emptyFile"
    touch "$TestServerFolder/$aFileName"
    expected=2

    wgetAndUnpack "$TestServerDomain/$aFileName" "emptyFileDownloaded" "$WgetToDir" "emptyFileDownloaded" > /dev/null 2>&1

    returnedVal=$?
    assertEquals $expected $returnedVal

    cleanupAfterTestServerTesting
}

function test_wgetAndUnpack_testGetFileNotTarball()
{   runTestServer

    aFileName="plainTextFile"
    echo "Some text!" > "$TestServerFolder/$aFileName"
    expected=2

    wgetAndUnpack "$TestServerDomain/$aFileName" "emptyFileDownloaded" "$WgetToDir" "emptyFileDownloaded" > /dev/null 2>&1

    returnedVal=$?
    assertEquals $expected $returnedVal

    cleanupAfterTestServerTesting
}

function test_wgetAndUnpack_testGetTarball()
{   runTestServer

    aFileName1="plainTextFile1"
    echo "Some text 1!" > $aFileName1
    aFileName2="plainTextFile2"
    echo "Some text 2!" > $aFileName2
    tarbFileName="tarFile.tgz"
    tar czf "$TestServerFolder/$tarbFileName" $aFileName1 $aFileName2
    rm $aFileName1 $aFileName2
    expected=0

    wgetAndUnpack "$TestServerDomain/$tarbFileName" "$tarbFileName" "$WgetToDir" "pathShouldNotExists" > /dev/null 2>&1

    returnedVal=$?
    assertEquals $expected $returnedVal
    assertTrue "Unpack folder not found" "[ -d $WgetToDir ]"
    assertTrue "Unpacked file1 not found" "[ -f $WgetToDir/$aFileName1 ]"
    assertTrue "Unpacked file2 not found" "[ -f $WgetToDir/$aFileName2 ]"

    # While everything is setup, run a test for when path already exists.
    expected=1
    wgetAndUnpack "$TestServerDomain/$tarbFileName" "$tarbFileName" "$WgetToDir" "$WgetToDir/$aFileName1" > /dev/null 2>&1
    returnedVal=$?
    assertEquals $expected $returnedVal

    cleanupAfterTestServerTesting
}

################################################################################

. ./ubsetup.sh -tt
. /usr/bin/shunit2
