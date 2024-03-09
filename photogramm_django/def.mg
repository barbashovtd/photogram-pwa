{
    "header": {
        "pipelineVersion": "2.2",
        "releaseVersion": "2023.3.0",
        "fileVersion": "1.1",
        "template": false,
        "nodesVersions": {
            "FeatureExtraction": "1.3",
            "ImageMatching": "2.0",
            "PrepareDenseScene": "3.1",
            "DepthMapFilter": "4.0",
            "StructureFromMotion": "3.3",
            "FeatureMatching": "2.0",
            "MeshFiltering": "3.0",
            "CameraInit": "9.0",
            "Meshing": "7.0",
            "DepthMap": "5.0",
            "Texturing": "6.0",
            "Publish": "1.3"
        }
    },
    "graph": {
        "DepthMapFilter_1": {
            "nodeType": "DepthMapFilter",
            "position": [
                1400,
                0
            ],
            "parallelization": {
                "blockSize": 24,
                "size": 4,
                "split": 1
            },
            "uids": {
                "0": "d22ce625b9f2b24d9cc94c263652efaf0ed105c2"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMap_1.input}",
                "depthMapsFolder": "{DepthMap_1.output}",
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "nNearestCams": 10,
                "minNumOfConsistentCams": 3,
                "minNumOfConsistentCamsWithLowSimilarity": 4,
                "pixToleranceFactor": 2.0,
                "pixSizeBall": 0,
                "pixSizeBallWithLowSimilarity": 0,
                "computeNormalMaps": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr"
            }
        },
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                400,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 4,
                "split": 1
            },
            "uids": {
                "0": "fa3c84eec8e4c7ea51a10d7582cda7d77466aeb7"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{FeatureExtraction_1.input}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "SequentialAndVocabularyTree",
                "tree": "${ALICEVISION_VOCTREE}",
                "weights": "",
                "minNbImages": 200,
                "maxDescriptors": 500,
                "nbMatches": 40,
                "nbNeighbors": 5,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/imageMatches.txt"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                200,
                0
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 4,
                "split": 1
            },
            "uids": {
                "0": "bd1b3ebde8e49255881559667f8928fbd4fb8b82"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{CameraInit_1.output}",
                "masksFolder": "",
                "maskExtension": "png",
                "maskInvert": false,
                "describerTypes": [
                    "dspsift"
                ],
                "describerPreset": "normal",
                "maxNbFeatures": 0,
                "describerQuality": "normal",
                "contrastFiltering": "GridSort",
                "relativePeakThreshold": 0.01,
                "gridFiltering": true,
                "workingColorSpace": "sRGB",
                "forceCpuExtraction": true,
                "maxThreads": 0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "StructureFromMotion_1": {
            "nodeType": "StructureFromMotion",
            "position": [
                800,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 4,
                "split": 1
            },
            "uids": {
                "0": "2749746a8761edebfd2451a80b587b273a3a0890"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{FeatureMatching_1.input}",
                "featuresFolders": "{FeatureMatching_1.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_1.output}"
                ],
                "describerTypes": "{FeatureMatching_1.describerTypes}",
                "localizerEstimator": "acransac",
                "observationConstraint": "Scale",
                "localizerEstimatorMaxIterations": 4096,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": false,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
                "nbFirstUnstableCameras": 30,
                "maxImagesPerGroup": 30,
                "bundleAdjustmentMaxOutliers": 50,
                "maxNumberOfMatches": 0,
                "minNumberOfMatches": 0,
                "minInputTrackLength": 2,
                "minNumberOfObservationsForTriangulation": 2,
                "minAngleForTriangulation": 3.0,
                "minAngleForLandmark": 2.0,
                "maxReprojectionError": 4.0,
                "minAngleInitialPair": 5.0,
                "maxAngleInitialPair": 40.0,
                "useOnlyMatchesFromInputFolder": false,
                "useRigConstraint": true,
                "rigMinNbCamerasForCalibration": 20,
                "lockAllIntrinsics": false,
                "minNbCamerasToRefinePrincipalPoint": 3,
                "filterTrackForks": false,
                "computeStructureColor": true,
                "useAutoTransform": true,
                "initialPairA": "",
                "initialPairB": "",
                "interFileExtension": ".abc",
                "logIntermediateSteps": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/sfm.abc",
                "outputViewsAndPoses": "{cache}/{nodeType}/{uid0}/cameras.sfm",
                "extraInfoFolder": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "PrepareDenseScene_1": {
            "nodeType": "PrepareDenseScene",
            "position": [
                1000,
                0
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 4,
                "split": 1
            },
            "uids": {
                "0": "4f2516cab6b1e54941d31748c23433d5b1a80458"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{StructureFromMotion_1.output}",
                "imagesFolders": [],
                "masksFolders": [],
                "maskExtension": "png",
                "outputFileType": "exr",
                "saveMetadata": true,
                "saveMatricesTxtFiles": false,
                "evCorrection": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "undistorted": "{cache}/{nodeType}/{uid0}/<VIEW_ID>.{outputFileTypeValue}"
            }
        },
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                0,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 4,
                "split": 1
            },
            "uids": {
                "0": "d51d4ca695b9f39fc1907a82fe6286f3eefe384a"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 320370120,
                        "poseId": 320370120,
                        "path": "/home/tim/Meshroom/alicevision dataset_monstree master mini6/IMG_1028.JPG",
                        "intrinsicId": 62557369,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"4.890000\", \"DateTime\": \"2017:07:18 15:31:37\", \"Exif:ApertureValue\": \"1.69599\", \"Exif:BrightnessValue\": \"4.88065\", \"Exif:ColorSpace\": \"65535\", \"Exif:CustomRendered\": \"2\", \"Exif:DateTimeDigitized\": \"2017:07:18 15:31:37\", \"Exif:DateTimeOriginal\": \"2017:07:18 15:31:37\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"24\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"3.99\", \"Exif:FocalLengthIn35mmFilm\": \"28\", \"Exif:LensMake\": \"Apple\", \"Exif:LensModel\": \"iPhone 7 back camera 3.99mm f/1.8\", \"Exif:LensSpecification\": \"3.99, 3.99, 1.8, 1.8\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"25\", \"Exif:PixelXDimension\": \"4032\", \"Exif:PixelYDimension\": \"3024\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:ShutterSpeedValue\": \"5.90695\", \"Exif:SubsecTimeDigitized\": \"070\", \"Exif:SubsecTimeOriginal\": \"070\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"1\", \"ExposureTime\": \"0.0166667\", \"FNumber\": \"1.8\", \"GPS:Altitude\": \"1224.76\", \"GPS:AltitudeRef\": \"0\", \"GPS:DateStamp\": \"2017:07:18\", \"GPS:DestBearing\": \"321.639\", \"GPS:DestBearingRef\": \"T\", \"GPS:HPositioningError\": \"12\", \"GPS:ImgDirection\": \"321.639\", \"GPS:ImgDirectionRef\": \"T\", \"GPS:Latitude\": \"37, 43, 23.86\", \"GPS:LatitudeRef\": \"N\", \"GPS:Longitude\": \"119, 36, 57.37\", \"GPS:LongitudeRef\": \"W\", \"GPS:Speed\": \"0.178955\", \"GPS:SpeedRef\": \"K\", \"GPS:TimeStamp\": \"22, 31, 36\", \"ICCProfile\": \"0, 0, 2, 36, 97, 112, 112, 108, 4, 0, 0, 0, 109, 110, 116, 114, 82, 71, 66, 32, 88, 89, 90, 32, 7, 223, 0, 10, 0, 14, 0, 13, 0, 8, 0, 57, 97, 99, 115, 112, 65, 80, 80, 76, 0, 0, 0, 0, 65, 80, 80, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ... [548 x uint8]\", \"ICCProfile:attributes\": \"Reflective, Glossy, Positive, Color\", \"ICCProfile:cmm_type\": \"1634758764\", \"ICCProfile:color_space\": \"RGB\", \"ICCProfile:copyright\": \"Copyright Apple Inc., 2015\", \"ICCProfile:creation_date\": \"2015:10:14 13:08:57\", \"ICCProfile:creator_signature\": \"6170706c\", \"ICCProfile:device_class\": \"Display device profile\", \"ICCProfile:flags\": \"Not Embedded, Independent\", \"ICCProfile:manufacturer\": \"4150504c\", \"ICCProfile:model\": \"0\", \"ICCProfile:platform_signature\": \"Apple Computer, Inc.\", \"ICCProfile:profile_connection_space\": \"XYZ\", \"ICCProfile:profile_description\": \"Display P3\", \"ICCProfile:profile_size\": \"548\", \"ICCProfile:profile_version\": \"4.0.0\", \"ICCProfile:rendering_intent\": \"Perceptual\", \"Make\": \"Apple\", \"Model\": \"iPhone 7\", \"Orientation\": \"6\", \"ResolutionUnit\": \"none\", \"Software\": \"10.3.2\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 703209551,
                        "poseId": 703209551,
                        "path": "/home/tim/Meshroom/alicevision dataset_monstree master mini6/IMG_1024.JPG",
                        "intrinsicId": 62557369,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"4.890000\", \"DateTime\": \"2017:07:18 15:31:28\", \"Exif:ApertureValue\": \"1.69599\", \"Exif:BrightnessValue\": \"5.17327\", \"Exif:ColorSpace\": \"65535\", \"Exif:DateTimeDigitized\": \"2017:07:18 15:31:28\", \"Exif:DateTimeOriginal\": \"2017:07:18 15:31:28\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"24\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"3.99\", \"Exif:FocalLengthIn35mmFilm\": \"28\", \"Exif:LensMake\": \"Apple\", \"Exif:LensModel\": \"iPhone 7 back camera 3.99mm f/1.8\", \"Exif:LensSpecification\": \"3.99, 3.99, 1.8, 1.8\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"40\", \"Exif:PixelXDimension\": \"4032\", \"Exif:PixelYDimension\": \"3024\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:ShutterSpeedValue\": \"6.90799\", \"Exif:SubsecTimeDigitized\": \"462\", \"Exif:SubsecTimeOriginal\": \"462\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"1\", \"ExposureTime\": \"0.00833333\", \"FNumber\": \"1.8\", \"GPS:Altitude\": \"1224.42\", \"GPS:AltitudeRef\": \"0\", \"GPS:DateStamp\": \"2017:07:18\", \"GPS:DestBearing\": \"7.97446\", \"GPS:DestBearingRef\": \"T\", \"GPS:HPositioningError\": \"8\", \"GPS:ImgDirection\": \"7.97446\", \"GPS:ImgDirectionRef\": \"T\", \"GPS:Latitude\": \"37, 43, 23.86\", \"GPS:LatitudeRef\": \"N\", \"GPS:Longitude\": \"119, 36, 57.18\", \"GPS:LongitudeRef\": \"W\", \"GPS:Speed\": \"0.0605214\", \"GPS:SpeedRef\": \"K\", \"GPS:TimeStamp\": \"22, 31, 28\", \"ICCProfile\": \"0, 0, 2, 36, 97, 112, 112, 108, 4, 0, 0, 0, 109, 110, 116, 114, 82, 71, 66, 32, 88, 89, 90, 32, 7, 223, 0, 10, 0, 14, 0, 13, 0, 8, 0, 57, 97, 99, 115, 112, 65, 80, 80, 76, 0, 0, 0, 0, 65, 80, 80, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ... [548 x uint8]\", \"ICCProfile:attributes\": \"Reflective, Glossy, Positive, Color\", \"ICCProfile:cmm_type\": \"1634758764\", \"ICCProfile:color_space\": \"RGB\", \"ICCProfile:copyright\": \"Copyright Apple Inc., 2015\", \"ICCProfile:creation_date\": \"2015:10:14 13:08:57\", \"ICCProfile:creator_signature\": \"6170706c\", \"ICCProfile:device_class\": \"Display device profile\", \"ICCProfile:flags\": \"Not Embedded, Independent\", \"ICCProfile:manufacturer\": \"4150504c\", \"ICCProfile:model\": \"0\", \"ICCProfile:platform_signature\": \"Apple Computer, Inc.\", \"ICCProfile:profile_connection_space\": \"XYZ\", \"ICCProfile:profile_description\": \"Display P3\", \"ICCProfile:profile_size\": \"548\", \"ICCProfile:profile_version\": \"4.0.0\", \"ICCProfile:rendering_intent\": \"Perceptual\", \"Make\": \"Apple\", \"Model\": \"iPhone 7\", \"Orientation\": \"6\", \"ResolutionUnit\": \"none\", \"Software\": \"10.3.2\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2003786643,
                        "poseId": 2003786643,
                        "path": "/home/tim/Meshroom/alicevision dataset_monstree master mini6/IMG_1040.JPG",
                        "intrinsicId": 62557369,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"4.890000\", \"DateTime\": \"2017:07:18 15:32:07\", \"Exif:ApertureValue\": \"1.69599\", \"Exif:BrightnessValue\": \"5.27233\", \"Exif:ColorSpace\": \"65535\", \"Exif:DateTimeDigitized\": \"2017:07:18 15:32:07\", \"Exif:DateTimeOriginal\": \"2017:07:18 15:32:07\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"24\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"3.99\", \"Exif:FocalLengthIn35mmFilm\": \"28\", \"Exif:LensMake\": \"Apple\", \"Exif:LensModel\": \"iPhone 7 back camera 3.99mm f/1.8\", \"Exif:LensSpecification\": \"3.99, 3.99, 1.8, 1.8\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"40\", \"Exif:PixelXDimension\": \"4032\", \"Exif:PixelYDimension\": \"3024\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:ShutterSpeedValue\": \"6.90799\", \"Exif:SubsecTimeDigitized\": \"397\", \"Exif:SubsecTimeOriginal\": \"397\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"1\", \"ExposureTime\": \"0.00833333\", \"FNumber\": \"1.8\", \"GPS:Altitude\": \"1225.15\", \"GPS:AltitudeRef\": \"0\", \"GPS:DateStamp\": \"2017:07:18\", \"GPS:DestBearing\": \"296.664\", \"GPS:DestBearingRef\": \"T\", \"GPS:HPositioningError\": \"16\", \"GPS:ImgDirection\": \"296.664\", \"GPS:ImgDirectionRef\": \"T\", \"GPS:Latitude\": \"37, 43, 23.87\", \"GPS:LatitudeRef\": \"N\", \"GPS:Longitude\": \"119, 36, 57.54\", \"GPS:LongitudeRef\": \"W\", \"GPS:Speed\": \"0.00208859\", \"GPS:SpeedRef\": \"K\", \"GPS:TimeStamp\": \"22, 32, 7\", \"ICCProfile\": \"0, 0, 2, 36, 97, 112, 112, 108, 4, 0, 0, 0, 109, 110, 116, 114, 82, 71, 66, 32, 88, 89, 90, 32, 7, 223, 0, 10, 0, 14, 0, 13, 0, 8, 0, 57, 97, 99, 115, 112, 65, 80, 80, 76, 0, 0, 0, 0, 65, 80, 80, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ... [548 x uint8]\", \"ICCProfile:attributes\": \"Reflective, Glossy, Positive, Color\", \"ICCProfile:cmm_type\": \"1634758764\", \"ICCProfile:color_space\": \"RGB\", \"ICCProfile:copyright\": \"Copyright Apple Inc., 2015\", \"ICCProfile:creation_date\": \"2015:10:14 13:08:57\", \"ICCProfile:creator_signature\": \"6170706c\", \"ICCProfile:device_class\": \"Display device profile\", \"ICCProfile:flags\": \"Not Embedded, Independent\", \"ICCProfile:manufacturer\": \"4150504c\", \"ICCProfile:model\": \"0\", \"ICCProfile:platform_signature\": \"Apple Computer, Inc.\", \"ICCProfile:profile_connection_space\": \"XYZ\", \"ICCProfile:profile_description\": \"Display P3\", \"ICCProfile:profile_size\": \"548\", \"ICCProfile:profile_version\": \"4.0.0\", \"ICCProfile:rendering_intent\": \"Perceptual\", \"Make\": \"Apple\", \"Model\": \"iPhone 7\", \"Orientation\": \"6\", \"ResolutionUnit\": \"none\", \"Software\": \"10.3.2\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2093542137,
                        "poseId": 2093542137,
                        "path": "/home/tim/Meshroom/alicevision dataset_monstree master mini6/IMG_1026.JPG",
                        "intrinsicId": 62557369,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"4.890000\", \"DateTime\": \"2017:07:18 15:31:32\", \"Exif:ApertureValue\": \"1.69599\", \"Exif:BrightnessValue\": \"5.00969\", \"Exif:ColorSpace\": \"65535\", \"Exif:CustomRendered\": \"2\", \"Exif:DateTimeDigitized\": \"2017:07:18 15:31:32\", \"Exif:DateTimeOriginal\": \"2017:07:18 15:31:32\", \"Exif:ExifVersion\": \"0221\", \"Exif:ExposureBiasValue\": \"0\", \"Exif:ExposureMode\": \"0\", \"Exif:ExposureProgram\": \"2\", \"Exif:Flash\": \"24\", \"Exif:FlashPixVersion\": \"0100\", \"Exif:FocalLength\": \"3.99\", \"Exif:FocalLengthIn35mmFilm\": \"28\", \"Exif:LensMake\": \"Apple\", \"Exif:LensModel\": \"iPhone 7 back camera 3.99mm f/1.8\", \"Exif:LensSpecification\": \"3.99, 3.99, 1.8, 1.8\", \"Exif:MeteringMode\": \"5\", \"Exif:PhotographicSensitivity\": \"25\", \"Exif:PixelXDimension\": \"4032\", \"Exif:PixelYDimension\": \"3024\", \"Exif:SceneCaptureType\": \"0\", \"Exif:SensingMethod\": \"2\", \"Exif:ShutterSpeedValue\": \"5.90695\", \"Exif:SubsecTimeDigitized\": \"966\", \"Exif:SubsecTimeOriginal\": \"966\", \"Exif:WhiteBalance\": \"0\", \"Exif:YCbCrPositioning\": \"1\", \"ExposureTime\": \"0.0166667\", \"FNumber\": \"1.8\", \"GPS:Altitude\": \"1224.68\", \"GPS:AltitudeRef\": \"0\", \"GPS:DateStamp\": \"2017:07:18\", \"GPS:DestBearing\": \"346.362\", \"GPS:DestBearingRef\": \"T\", \"GPS:HPositioningError\": \"8\", \"GPS:ImgDirection\": \"346.362\", \"GPS:ImgDirectionRef\": \"T\", \"GPS:Latitude\": \"37, 43, 23.81\", \"GPS:LatitudeRef\": \"N\", \"GPS:Longitude\": \"119, 36, 57.29\", \"GPS:LongitudeRef\": \"W\", \"GPS:Speed\": \"0.188065\", \"GPS:SpeedRef\": \"K\", \"GPS:TimeStamp\": \"22, 31, 32\", \"ICCProfile\": \"0, 0, 2, 36, 97, 112, 112, 108, 4, 0, 0, 0, 109, 110, 116, 114, 82, 71, 66, 32, 88, 89, 90, 32, 7, 223, 0, 10, 0, 14, 0, 13, 0, 8, 0, 57, 97, 99, 115, 112, 65, 80, 80, 76, 0, 0, 0, 0, 65, 80, 80, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ... [548 x uint8]\", \"ICCProfile:attributes\": \"Reflective, Glossy, Positive, Color\", \"ICCProfile:cmm_type\": \"1634758764\", \"ICCProfile:color_space\": \"RGB\", \"ICCProfile:copyright\": \"Copyright Apple Inc., 2015\", \"ICCProfile:creation_date\": \"2015:10:14 13:08:57\", \"ICCProfile:creator_signature\": \"6170706c\", \"ICCProfile:device_class\": \"Display device profile\", \"ICCProfile:flags\": \"Not Embedded, Independent\", \"ICCProfile:manufacturer\": \"4150504c\", \"ICCProfile:model\": \"0\", \"ICCProfile:platform_signature\": \"Apple Computer, Inc.\", \"ICCProfile:profile_connection_space\": \"XYZ\", \"ICCProfile:profile_description\": \"Display P3\", \"ICCProfile:profile_size\": \"548\", \"ICCProfile:profile_version\": \"4.0.0\", \"ICCProfile:rendering_intent\": \"Perceptual\", \"Make\": \"Apple\", \"Model\": \"iPhone 7\", \"Orientation\": \"6\", \"ResolutionUnit\": \"none\", \"Software\": \"10.3.2\", \"XResolution\": \"72\", \"YResolution\": \"72\", \"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 62557369,
                        "initialFocalLength": 3.99,
                        "focalLength": 3.99,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "type": "radial3",
                        "width": 4032,
                        "height": 3024,
                        "sensorWidth": 4.89,
                        "sensorHeight": 3.6675,
                        "serialNumber": "/home/tim/Meshroom/alicevision dataset_monstree master mini6_Apple_iPhone 7",
                        "principalPoint": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "initializationMode": "estimated",
                        "distortionInitializationMode": "none",
                        "distortionParams": [
                            0.0,
                            0.0,
                            0.0
                        ],
                        "undistortionOffset": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "undistortionParams": [],
                        "locked": false
                    }
                ],
                "sensorDatabase": "${ALICEVISION_SENSOR_DB}",
                "lensCorrectionProfileInfo": "${ALICEVISION_LENS_PROFILE_INFO}",
                "lensCorrectionProfileSearchIgnoreCameraModel": true,
                "defaultFieldOfView": 45.0,
                "groupCameraFallback": "folder",
                "allowedCameraModels": [
                    "pinhole",
                    "radial1",
                    "radial3",
                    "brown",
                    "fisheye4",
                    "fisheye1",
                    "3deanamorphic4",
                    "3deradial4",
                    "3declassicld"
                ],
                "rawColorInterpretation": "LibRawWhiteBalancing",
                "colorProfileDatabase": "${ALICEVISION_COLOR_PROFILE_DB}",
                "errorOnMissingColorProfile": true,
                "viewIdMethod": "metadata",
                "viewIdRegex": ".*?(\\d+)",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/cameraInit.sfm"
            }
        },
        "DepthMap_1": {
            "nodeType": "DepthMap",
            "position": [
                1200,
                0
            ],
            "parallelization": {
                "blockSize": 12,
                "size": 4,
                "split": 1
            },
            "uids": {
                "0": "9154cb5e6b93dd5fae2b38699a69d33ec9f876b6"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{PrepareDenseScene_1.input}",
                "imagesFolder": "{PrepareDenseScene_1.output}",
                "downscale": 2,
                "minViewAngle": 2.0,
                "maxViewAngle": 70.0,
                "tiling": {
                    "tileBufferWidth": 1024,
                    "tileBufferHeight": 1024,
                    "tilePadding": 64,
                    "autoAdjustSmallImage": true
                },
                "chooseTCamsPerTile": true,
                "maxTCams": 10,
                "sgm": {
                    "sgmScale": 2,
                    "sgmStepXY": 2,
                    "sgmStepZ": -1,
                    "sgmMaxTCamsPerTile": 4,
                    "sgmWSH": 4,
                    "sgmUseSfmSeeds": true,
                    "sgmSeedsRangeInflate": 0.2,
                    "sgmDepthThicknessInflate": 0.0,
                    "sgmMaxSimilarity": 1.0,
                    "sgmGammaC": 5.5,
                    "sgmGammaP": 8.0,
                    "sgmP1": 10.0,
                    "sgmP2Weighting": 100.0,
                    "sgmMaxDepths": 1500,
                    "sgmFilteringAxes": "YX",
                    "sgmDepthListPerTile": true,
                    "sgmUseConsistentScale": false
                },
                "refine": {
                    "refineEnabled": true,
                    "refineScale": 1,
                    "refineStepXY": 1,
                    "refineMaxTCamsPerTile": 4,
                    "refineSubsampling": 10,
                    "refineHalfNbDepths": 15,
                    "refineWSH": 3,
                    "refineSigma": 15.0,
                    "refineGammaC": 15.5,
                    "refineGammaP": 8.0,
                    "refineInterpolateMiddleDepth": false,
                    "refineUseConsistentScale": false
                },
                "colorOptimization": {
                    "colorOptimizationEnabled": true,
                    "colorOptimizationNbIterations": 100
                },
                "customPatchPattern": {
                    "sgmUseCustomPatchPattern": false,
                    "refineUseCustomPatchPattern": false,
                    "customPatchPatternSubparts": [],
                    "customPatchPatternGroupSubpartsPerLevel": false
                },
                "intermediateResults": {
                    "exportIntermediateDepthSimMaps": false,
                    "exportIntermediateNormalMaps": false,
                    "exportIntermediateVolumes": false,
                    "exportIntermediateCrossVolumes": false,
                    "exportIntermediateTopographicCutVolumes": false,
                    "exportIntermediateVolume9pCsv": false,
                    "exportTilePattern": false
                },
                "nbGPUs": 0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "depth": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap.exr",
                "sim": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_simMap.exr",
                "tilePattern": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_tilePattern.obj",
                "depthSgm": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap_sgm.exr",
                "depthSgmUpscaled": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap_sgmUpscaled.exr",
                "depthRefined": "{cache}/{nodeType}/{uid0}/<VIEW_ID>_depthMap_refinedFused.exr"
            }
        },
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                600,
                0
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 4,
                "split": 1
            },
            "uids": {
                "0": "76dd09fde6dc95ea5911446955cf06fa40540c25"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{ImageMatching_1.input}",
                "featuresFolders": "{ImageMatching_1.featuresFolders}",
                "imagePairsList": "{ImageMatching_1.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}",
                "photometricMatchingMethod": "ANN_L2",
                "geometricEstimator": "acransac",
                "geometricFilterType": "fundamental_matrix",
                "distanceRatio": 0.8,
                "maxIteration": 2048,
                "geometricError": 0.0,
                "knownPosesGeometricErrorMax": 5.0,
                "minRequired2DMotion": -1.0,
                "maxMatches": 0,
                "savePutativeMatches": false,
                "crossMatching": false,
                "guidedMatching": false,
                "matchFromKnownCameraPoses": false,
                "exportDebugFiles": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/"
            }
        },
        "MeshFiltering_1": {
            "nodeType": "MeshFiltering",
            "position": [
                1800,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "752fe1ce2d0bae1e705233ec00b1f87fdd9695bc"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputMesh": "{Meshing_1.outputMesh}",
                "outputMeshFileType": "obj",
                "keepLargestMeshOnly": false,
                "smoothingSubset": "all",
                "smoothingBoundariesNeighbours": 0,
                "smoothingIterations": 5,
                "smoothingLambda": 1.0,
                "filteringSubset": "all",
                "filteringIterations": 1,
                "filterLargeTrianglesFactor": 60.0,
                "filterTrianglesRatio": 0.0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}"
            }
        },
        "Meshing_1": {
            "nodeType": "Meshing",
            "position": [
                1600,
                0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "f0a981f7f2b74e6f38bc650201b9f3facf9273e3"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{DepthMapFilter_1.input}",
                "depthMapsFolder": "{DepthMapFilter_1.output}",
                "outputMeshFileType": "obj",
                "useBoundingBox": false,
                "boundingBox": {
                    "bboxTranslation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "bboxRotation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "bboxScale": {
                        "x": 1.0,
                        "y": 1.0,
                        "z": 1.0
                    }
                },
                "estimateSpaceFromSfM": true,
                "estimateSpaceMinObservations": 3,
                "estimateSpaceMinObservationAngle": 10.0,
                "maxInputPoints": 50000000,
                "maxPoints": 500000,
                "maxPointsPerVoxel": 1000000,
                "minStep": 2,
                "partitioning": "singleBlock",
                "repartition": "multiResolution",
                "angleFactor": 15.0,
                "simFactor": 15.0,
                "minVis": 2,
                "pixSizeMarginInitCoef": 2.0,
                "pixSizeMarginFinalCoef": 4.0,
                "voteMarginFactor": 4.0,
                "contributeMarginFactor": 2.0,
                "simGaussianSizeInit": 10.0,
                "simGaussianSize": 10.0,
                "minAngleThreshold": 1.0,
                "refineFuse": true,
                "helperPointsGridSize": 10,
                "densify": false,
                "densifyNbFront": 1,
                "densifyNbBack": 1,
                "densifyScale": 20.0,
                "nPixelSizeBehind": 4.0,
                "fullWeight": 1.0,
                "voteFilteringForWeaklySupportedSurfaces": true,
                "addLandmarksToTheDensePointCloud": false,
                "invertTetrahedronBasedOnNeighborsNbIterations": 10,
                "minSolidAngleRatio": 0.2,
                "nbSolidAngleFilteringIterations": 2,
                "colorizeOutput": false,
                "addMaskHelperPoints": false,
                "maskHelperPointsWeight": 1.0,
                "maskBorderSize": 4,
                "maxNbConnectedHelperPoints": 50,
                "saveRawDensePointCloud": false,
                "exportDebugTetrahedralization": false,
                "seed": 0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputMesh": "{cache}/{nodeType}/{uid0}/mesh.{outputMeshFileTypeValue}",
                "output": "{cache}/{nodeType}/{uid0}/densePointCloud.abc"
            }
        },
        "Texturing_1": {
            "nodeType": "Texturing",
            "position": [
                2016,
                10
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "1bcdad605b6fcc7402393bfb4aa72c3b3ae66ebb"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "input": "{Meshing_1.output}",
                "imagesFolder": "{DepthMap_1.imagesFolder}",
                "inputMesh": "{MeshFiltering_1.outputMesh}",
                "inputRefMesh": "",
                "textureSide": 8192,
                "downscale": 2,
                "outputMeshFileType": "obj",
                "colorMapping": {
                    "enable": true,
                    "colorMappingFileType": "png"
                },
                "bumpMapping": {
                    "enable": true,
                    "bumpType": "Normal",
                    "normalFileType": "exr",
                    "heightFileType": "exr"
                },
                "displacementMapping": {
                    "enable": true,
                    "displacementMappingFileType": "exr"
                },
                "unwrapMethod": "Basic",
                "useUDIM": true,
                "fillHoles": false,
                "padding": 5,
                "multiBandDownscale": 4,
                "multiBandNbContrib": {
                    "high": 1,
                    "midHigh": 5,
                    "midLow": 10,
                    "low": 0
                },
                "useScore": true,
                "bestScoreThreshold": 0.1,
                "angleHardThreshold": 90.0,
                "workingColorSpace": "sRGB",
                "outputColorSpace": "sRGB",
                "correctEV": true,
                "forceVisibleByAllVertices": false,
                "flipNormals": false,
                "visibilityRemappingMethod": "PullPush",
                "subdivisionTargetRatio": 0.8,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{cache}/{nodeType}/{uid0}/",
                "outputMesh": "{cache}/{nodeType}/{uid0}/texturedMesh.{outputMeshFileTypeValue}",
                "outputMaterial": "{cache}/{nodeType}/{uid0}/texturedMesh.mtl",
                "outputTextures": "{cache}/{nodeType}/{uid0}/texture_*.png"
            }
        },
        "Publish_1": {
            "nodeType": "Publish",
            "position": [
                2267,
                57
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uids": {
                "0": "efd26270d4bbaa12736c71cf53793b34ec02e970"
            },
            "internalFolder": "{cache}/{nodeType}/{uid0}/",
            "inputs": {
                "inputFiles": [
                    "{Texturing_1.outputMesh}"
                ],
                "output": "",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {}
        }
    }
}