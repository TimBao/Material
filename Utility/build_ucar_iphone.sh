#!/bin/sh

#parse input to build debug or relase
echo ""
echo "usage: build_ucar_iphone.sh release or build_ucar_iphone debug default is debug"
echo ""

if [ $1 == "release" ]; then
    BUILD_TYPE=Release
else
    BUILD_TYPE=Distribution
fi

CURDIR=$PWD
PROJECT_DIR=$CURDIR/../ucar
APPLICATION_NAME=UCar
#DEVELOPER_NAME=iPhone Distribution: Beijing XinDaoHaoDa Technology Co., Ltd.
PROFILE_NAME=$(head -n 1 provisoning_profile.txt)
PROVISONING_PROFILE=${PROJECT_DIR}/UCar/cer/${PROFILE_NAME}
CPU_ARCHITECTURE="armv7 arm64"
SIMULATOR_OR_IOS_SDK=iphoneos
DEVELOPMENT_TARGET=7.0
SDK_VERSION=8.1
OUTPUT=$CURDIR/output

if [ -d ${OUTPUT}/${BUILD_TYPE}-${SIMULATOR_OR_IOS_SDK} ]
then
    rm -rf ${OUTPUT}/${BUILD_TYPE}-${SIMULATOR_OR_IOS_SDK}
else
    mkdir ${OUTPUT}
fi

##clean
cd ${PROJECT_DIR}

echo "====>> clean output"
xcodebuild clean 2>/dev/null 2>&1

echo "====>> compile project"
if [ $2 == "online" ]; then
    echo "==>ios build type"
    echo ${BUILD_TYPE}
    echo "current path="
    echo $PWD
    #xcodebuild -project ${PROJECT_DIR}/${APPLICATION_NAME}.xcodeproj -configuration ${BUILD_TYPE} -target ${APPLICATION_NAME} -sdk ${SIMULATOR_OR_IOS_SDK}${SDK_VERSION} ARCHS='armv7 arm64' IOS_DEVELOPMENT_TARGET=${DEVELOPMENT_TARGET}
    xcodebuild -scheme ${APPLICATION_NAME} -archivePath ${OUTPUT}/${APPLICATION_NAME}.xcarchive archive
    xcodebuild -exportArchive -exportFormat ipa -archivePath ${OUTPUT}/${APPLICATION_NAME}.xcarchive -exportPath ${OUTPUT}/${APPLICATION_NAME}.ipa
else
    echo "==>---->ios build type"
    echo ${BUILD_TYPE}
    xcodebuild -project ${PROJECT_DIR}/${APPLICATION_NAME}.xcodeproj -configuration ${BUILD_TYPE} -target ${APPLICATION_NAME} -sdk ${SIMULATOR_OR_IOS_SDK}${SDK_VERSION} ARCHS='armv7 arm64' IOS_DEVELOPMENT_TARGET=${DEVELOPMENT_TARGET} GCC_PREPROCESSOR_DEFINITIONS="DEBUG_TEST_STATUS"
#fi

    #copy app to release folder
    echo "====>> copy app to output folder"
    cp -r ${PROJECT_DIR}/build/${BUILD_TYPE}-${SIMULATOR_OR_IOS_SDK} ${OUTPUT}

    #if [ ${BUILD_TYPE} == "Release" ]; then
    echo "=====>> archiving app to ipa "
    #package app to ipa
    xcrun -sdk ${SIMULATOR_OR_IOS_SDK}${SDK_VERSION} PackageApplication -v "${OUTPUT}/${BUILD_TYPE}-${SIMULATOR_OR_IOS_SDK}/${APPLICATION_NAME}.app" -o "${OUTPUT}/${BUILD_TYPE}-${SIMULATOR_OR_IOS_SDK}/${APPLICATION_NAME}.ipa"
    #xcrun -sdk ${SIMULATOR_OR_IOS_SDK}${SDK_VERSION} PackageApplication -v "${OUTPUT}/${BUILD_TYPE}-${SIMULATOR_OR_IOS_SDK}/${APPLICATION_NAME}.app" -o "${OUTPUT}/${BUILD_TYPE}-${SIMULATOR_OR_IOS_SDK}/${APPLICATION_NAME}.ipa" --embed "${PROVISONING_PROFILE}"
    #fi
fi

cd ${CURDIR}
