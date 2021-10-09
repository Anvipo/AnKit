#!/bin/sh

#  create_xcframework.sh
#  Design-system
#
#  Created by Anvipo on 29.08.2021.
#




# ---------------
# Make xcarchives
# ---------------

BUILDED_ARCHIVES_iOS_FOLDER_PATH="${SRCROOT}/Scripts/Build/Archives/iOS"

echo "Will delete \"${BUILDED_ARCHIVES_iOS_FOLDER_PATH}\" folder"
rm -rf "${BUILDED_ARCHIVES_iOS_FOLDER_PATH}"
echo "Did delete \"${BUILDED_ARCHIVES_iOS_FOLDER_PATH}\" folder"

echo "Will make \"${BUILDED_ARCHIVES_iOS_FOLDER_PATH}\" folder"
mkdir -p "${BUILDED_ARCHIVES_iOS_FOLDER_PATH}"
echo "Did make \"${BUILDED_ARCHIVES_iOS_FOLDER_PATH}\" folder"

iOS_SCHEME_NAME=$PROJECT_NAME




# ---------------------------
# Make archive for iOS device
# ---------------------------

iOS_DEVICE_ARCHIVE_PATH="${BUILDED_ARCHIVES_iOS_FOLDER_PATH}/${PROJECT_NAME}-iOS-device.xcarchive"

echo "Will make archive for iOS device at \"${iOS_DEVICE_ARCHIVE_PATH}\""
xcodebuild archive \
    -quiet \
    -scheme "${iOS_SCHEME_NAME}" \
    -archivePath "${iOS_DEVICE_ARCHIVE_PATH}" \
    -sdk iphoneos \
    SKIP_INSTALL=NO \
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
echo "Did make archive for iOS device at \"${iOS_DEVICE_ARCHIVE_PATH}\""




# ------------------------------
# Make archive for iOS simulator
# ------------------------------

iOS_SIMULATOR_ARCHIVE_PATH="${BUILDED_ARCHIVES_iOS_FOLDER_PATH}/${PROJECT_NAME}-iOS-simulator.xcarchive"

echo "Will make archive for iOS simulator at \"${iOS_SIMULATOR_ARCHIVE_PATH}\""
xcodebuild archive \
    -quiet \
    -scheme "${iOS_SCHEME_NAME}" \
    -archivePath "${iOS_SIMULATOR_ARCHIVE_PATH}" \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO \
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
echo "Did make archive for iOS simulator at \"${iOS_SIMULATOR_ARCHIVE_PATH}\""




# -----------------
# Make xcframeworks
# -----------------

FRAMEWORK_NAME=$PROJECT_NAME

iOS_DEVICE_FRAMEWORK="${iOS_DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework"

iOS_SIMULATOR_FRAMEWORK="${iOS_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework"




# -------------------------------
# Make XCFramework folder
# -------------------------------

CREATED_XCFRAMEWORK_FOLDER_PATH="${SRCROOT}/Scripts/Build/XCFramework"

echo "Will delete \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" folder"
rm -rf "${CREATED_XCFRAMEWORK_FOLDER_PATH}"
echo "Did delete \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" folder"

echo "Will make \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" folder"
mkdir -p "${CREATED_XCFRAMEWORK_FOLDER_PATH}"
echo "Did make \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" folder"




# -------------------
# Make XCFramework
# -------------------

XCFRAMEWORK_PATH="${CREATED_XCFRAMEWORK_FOLDER_PATH}/${PROJECT_NAME}.xcframework"

echo "Will create XCFramework at \"${XCFRAMEWORK_PATH}\""
xcodebuild -create-xcframework \
    -framework "${iOS_DEVICE_FRAMEWORK}" \
    -framework "${iOS_SIMULATOR_FRAMEWORK}" \
    -output "${XCFRAMEWORK_PATH}"
echo "Did create XCFramework at \"${XCFRAMEWORK_PATH}\""

open "$CREATED_XCFRAMEWORK_FOLDER_PATH"
