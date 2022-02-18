//
//  AWS.swift
//  
//
//  Created by Jonas Wippermann on 13.02.22.
//

import Foundation

struct AWS {
    /// https://docs.aws.amazon.com/general/latest/gr/lambda-service.html
    static let regions: Set<String> = ["us-east-2","us-east-1","us-west-1","us-west-2","af-south-1","ap-east-1","ap-southeast-3","ap-south-1","ap-northeast-3","ap-northeast-2","ap-southeast-1","ap-southeast-2","ap-northeast-1","ca-central-1","eu-central-1","eu-west-1","eu-west-2","eu-south-1","eu-west-3","eu-north-1","me-south-1","sa-east-1","us-gov-east-1","us-gov-west-1"]

    /// https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html
    static let runtimes: Set<String> = ["nodejs10.x", "nodejs12.x", "nodejs14.x", "python2.7", "python3.6", "python3.7", "python3.8", "python3.9", "ruby2.5", "ruby2.7", "java8", "java8.al2", "java11", "go1.x", "dotnetcore2.1", "dotnetcore3.1", "provided", "provided.al2"]

    static let architectures: Set<String> = ["arm64", "x86_64"]

    /// https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html
    static let reservedEnvironmentValues: Set<String> = [
        "_HANDLER", "_X_AMZN_TRACE_ID", "AWS_REGION", "AWS_EXECUTION_ENV", "AWS_LAMBDA_FUNCTION_NAME", "AWS_LAMBDA_FUNCTION_MEMORY_SIZE", "AWS_LAMBDA_FUNCTION_VERSION", "AWS_LAMBDA_INITIALIZATION_TYPE", "AWS_LAMBDA_LOG_GROUP_NAME", "AWS_LAMBDA_LOG_STREAM_NAME", "AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "AWS_SESSION_TOKEN", "AWS_LAMBDA_RUNTIME_API", "LAMBDA_TASK_ROOT", "LAMBDA_RUNTIME_DIR", "TZ"
    ]

    /// extracted from https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazons3.html#amazons3-actions-as-permissions
    static let s3IAMActions: Set<String> = ["s3:AbortMultipartUpload",
                               "s3:BypassGovernanceRetention",
                               "s3:CreateAccessPoint",
                               "s3:CreateAccessPointForObjectLambda",
                               "s3:CreateBucket",
                               "s3:CreateJob",
                               "s3:CreateMultiRegionAccessPoint",
                               "s3:DeleteAccessPoint",
                               "s3:DeleteAccessPointForObjectLambda",
                               "s3:DeleteAccessPointPolicy",
                               "s3:DeleteAccessPointPolicyForObjectLambda",
                               "s3:DeleteBucket",
                               "s3:DeleteBucketPolicy",
                               "s3:DeleteBucketWebsite",
                               "s3:DeleteJobTagging",
                               "s3:DeleteMultiRegionAccessPoint",
                               "s3:DeleteObject",
                               "s3:DeleteObjectTagging",
                               "s3:DeleteObjectVersion",
                               "s3:DeleteObjectVersionTagging",
                               "s3:DeleteStorageLensConfiguration",
                               "s3:DeleteStorageLensConfigurationTagging",
                               "s3:DescribeJob",
                               "s3:DescribeMultiRegionAccessPointOperatio",
                               "s3:GetAccelerateConfiguration",
                               "s3:GetAccessPoint",
                               "s3:GetAccessPointConfigurationForObjectLambda",
                               "s3:GetAccessPointForObjectLambda",
                               "s3:GetAccessPointPolicy",
                               "s3:GetAccessPointPolicyForObjectLambda",
                               "s3:GetAccessPointPolicyStatus",
                               "s3:GetAccessPointPolicyStatusForObjectLambda",
                               "s3:GetAccountPublicAccessBlock",
                               "s3:GetAnalyticsConfiguration",
                               "s3:GetBucketAcl",
                               "s3:GetBucketCORS",
                               "s3:GetBucketLocation",
                               "s3:GetBucketLogging",
                               "s3:GetBucketNotification",
                               "s3:GetBucketObjectLockConfiguration",
                               "s3:GetBucketOwnershipControls",
                               "s3:GetBucketPolicy",
                               "s3:GetBucketPolicyStatus",
                               "s3:GetBucketPublicAccessBlock",
                               "s3:GetBucketRequestPayment",
                               "s3:GetBucketTagging",
                               "s3:GetBucketVersioning",
                               "s3:GetBucketWebsite",
                               "s3:GetEncryptionConfiguration",
                               "s3:GetIntelligentTieringConfiguration",
                               "s3:GetInventoryConfiguration",
                               "s3:GetJobTagging",
                               "s3:GetLifecycleConfiguration",
                               "s3:GetMetricsConfiguration",
                               "s3:GetMultiRegionAccessPoint",
                               "s3:GetMultiRegionAccessPointPolicy",
                               "s3:GetMultiRegionAccessPointPolicyStatus",
                               "s3:GetObject",
                               "s3:GetObjectAcl",
                               "s3:GetObjectLegalHold",
                               "s3:GetObjectRetention",
                               "s3:GetObjectTagging",
                               "s3:GetObjectTorrent",
                               "s3:GetObjectVersion",
                               "s3:GetObjectVersionAcl",
                               "s3:GetObjectVersionForReplication",
                               "s3:GetObjectVersionTagging",
                               "s3:GetObjectVersionTorrent",
                               "s3:GetReplicationConfiguration",
                               "s3:GetStorageLensConfiguration",
                               "s3:GetStorageLensConfigurationTagging",
                               "s3:GetStorageLensDashboard",
                               "s3:InitiateReplication",
                               "s3:ListAccessPoints",
                               "s3:ListAccessPointsForObjectLambda",
                               "s3:ListAllMyBuckets",
                               "s3:ListBucket",
                               "s3:ListBucketMultipartUploads",
                               "s3:ListBucketVersions",
                               "s3:ListJobs",
                               "s3:ListMultiRegionAccessPoint",
                               "s3:ListMultipartUploadParts",
                               "s3:ListStorageLensConfigurations",
                               "s3:ObjectOwnerOverrideToBucketOwner",
                               "s3:PutAccelerateConfiguration",
                               "s3:PutAccessPointConfigurationForObjectLambda",
                               "s3:PutAccessPointPolicy",
                               "s3:PutAccessPointPolicyForObjectLambda",
                               "s3:PutAccessPointPublicAccessBlock",
                               "s3:PutAccountPublicAccessBlock",
                               "s3:PutAnalyticsConfiguration",
                               "s3:PutBucketAcl",
                               "s3:PutBucketCORS",
                               "s3:PutBucketLogging",
                               "s3:PutBucketNotification",
                               "s3:PutBucketObjectLockConfiguration",
                               "s3:PutBucketOwnershipControls",
                               "s3:PutBucketPolicy",
                               "s3:PutBucketPublicAccessBlock",
                               "s3:PutBucketRequestPayment",
                               "s3:PutBucketTagging",
                               "s3:PutBucketVersioning",
                               "s3:PutBucketWebsite",
                               "s3:PutEncryptionConfiguration",
                               "s3:PutIntelligentTieringConfiguration",
                               "s3:PutInventoryConfiguration",
                               "s3:PutJobTagging",
                               "s3:PutLifecycleConfiguration",
                               "s3:PutMetricsConfiguration",
                               "s3:PutMultiRegionAccessPointPolicy",
                               "s3:PutObject",
                               "s3:PutObjectAcl",
                               "s3:PutObjectLegalHold",
                               "s3:PutObjectRetention",
                               "s3:PutObjectTagging",
                               "s3:PutObjectVersionAcl",
                               "s3:PutObjectVersionTagging",
                               "s3:PutReplicationConfiguration",
                               "s3:PutStorageLensConfiguration",
                               "s3:PutStorageLensConfigurationTagging",
                               "s3:ReplicateDelete",
                               "s3:ReplicateObject",
                               "s3:ReplicateTags",
                               "s3:RestoreObject",
                               "s3:UpdateJobPriority",
                               "s3:UpdateJobStatus"]

    static let nonExistentS3IAMActions: Set<String> = [
        "s3:ModifyObject", "s3:MergeObject", "s3:UpdateObject", "s3:ListFooBar"
    ]

    static let httpMethods: Set<String> = ["get", "head", "post", "put", "patch", "options", "delete"]
}
