
# FaaS Fault Injection Observations

best viewed [online](https://www.craft.do/s/OQyC028bysx6NM)

also available as [PDF file](observations.pdf)


| **Experiment ID** | **Configuration Node**                          | **Constraint**   | **Violation**          | **Deployment Result** | **API responses**   | **notes**                                                                                |
| ----------------- | ----------------------------------------------- | ---------------- | ---------------------- | --------------------- | ------------------- | ---------------------------------------------------------------------------------------- |
| 001               | functions.bye.events.0.httpApi.method           | Enumeration      | Unexpected Value       | Deployment Error      | n.a.                |                                                                                          |
| 002               | functions.bye.handler                           | Reference        | Append                 | Deployment Success    | Runtime Error       | Internal Server Error                                                                    |
| 003               | functions.bye.layers.0                          | Reference        | Change                 | Deployment Error      | n.a.                |                                                                                          |
| 004               | functions.bye.maximumEventAge                   | Range            | Above                  | Deployment Error      | n.a.                |                                                                                          |
| 005               | functions.bye.maximumEventAge                   | WholeNumber      | Fractional             | Deployment Error      | n.a.                |                                                                                          |
| 006               | functions.bye.provisionedConcurrency            | Range            | Above                  | Deployment Error      | n.a.                |                                                                                          |
| 007               | functions.bye.provisionedConcurrency            | WholeNumber      | Fractional             | Deployment Error      | n.a.                |                                                                                          |
| 008               | functions.bye.reservedConcurrency               | Range            | Above                  | Deployment Error      | n.a.                |                                                                                          |
| 009               | functions.bye.reservedConcurrency               | Range            | Below                  | Deployment Error      | n.a.                |                                                                                          |
| 010               | functions.bye.runtime                           | Enumeration      | Unexpected Value       | Deployment Error      | n.a.                | "member must satisfy enum value set"                                                     |
| 010_b             | functions.bye.runtime                           | Enumeration      | Expected but Different | Deployment Error      | n.a.                | FUNCTION_ERROR_INIT_FAILURE                                                              |
| 011               | functions.bye.timeout                           | Range            | Above                  | Deployment Error      | n.a.                |                                                                                          |
| 012               | functions.hello.architecture                    | Enumeration      | Unexpected Value       | Deployment Error      | n.a.                |                                                                                          |
| 012_b             | functions.hello.architecture                    | Enumeration      | Expected but Different | Deployment Success    | Successful Response | Changed architecture seems to be compatible                                              |
| 013               | functions.hello.environment                     | NotReserved      | Use Reserved Option    | Deployment Error      | n.a.                | _X_AMZN_TRACE_ID: Key Validation                                                         |
| 013_b             | functions.hello.environment                     | NotReserved      | Use Reserved Option    | Deployment Success    | Successful Response | TZ should be reserved but no error                                                       |
| 013_c             | functions.hello.environment                     | NotReserved      | Use Reserved Option    | Deployment Error      | n.a.                | AWS_REGION: Reserved Value error                                                         |
| 014               | functions.hello.events.0.httpApi.method         | Enumeration      | Unexpected Value       | Deployment Error      | n.a.                |                                                                                          |
| 015               | functions.hello.handler                         | Reference        | Change                 | Deployment Success    | Runtime Error       | Internal Server Error                                                                    |
| 016               | functions.hello.maximumRetryAttempts            | Range            | Above                  | Deployment Error      | n.a.                |                                                                                          |
| 017               | functions.hello.memorySize                      | Range            | Above                  | Deployment Error      | n.a.                |                                                                                          |
| 018               | functions.hello.memorySize                      | Range            | Below                  | Deployment Error      | n.a.                |                                                                                          |
| 019               | functions.hello.runtime                         | Enumeration      | Expected but Different | Deployment Error      | n.a.                | runtime incompatible with architecture                                                   |
| 020               | functions.hello.vpc.securityGroupIds.0          | Reference        | Change                 | Deployment Error      | n.a.                | Validation Error                                                                         |
| 021               | functions.hello.vpc.subnetIds.0                 | Reference        | Change                 | Deployment Error      | n.a.                | Validation Error                                                                         |
| 022               | functions.imageHello.events.0.httpApi.method    | Enumeration      | Expected but Different | Deployment Success    | Runtime Error       | Not Found (GET is now OPTIONS)                                                           |
| 023               | functions.imageHello.image                      | Reference        | Change                 | Deployment Error      | n.a.                |                                                                                          |
| 024               | functions.imageHello.image                      | AtMostOne        | Specify Both           | Deployment Success    | Successful Response | Duplicate option is ignored by serverless framework                                      |
| 025               | functions.packagedHello.events.0.httpApi.method | Enumeration      | Expected but Different | Deployment Success    | Runtime Error       | Not Found (GET is now OPTIONS)                                                           |
| 026               | functions.packagedHello.handler                 | Reference        | Change                 | Deployment Success    | Runtime Error       | Internal Server Error                                                                    |
| 027               | functions.packagedHello.package                 | AtMostOne        | Specify Both           | Deployment Error      | n.a.                | either option must be specified, but not both                                            |
| 028               | functions.packagedHello.package.artifact        | Reference        | Change                 | Deployment Error      | n.a.                |                                                                                          |
| 029               | functions.packagedHello.runtime                 | Enumeration      | Expected but Different | Deployment Success    | Runtime Error       | Internal Server Error                                                                    |
| 030               | provider.iam.role.statements.0.Action           | Enumeration      | Unexpected Value       | Deployment Success    | Deployment Success  | IAM permission action should not exist, but did not cause failure (wasn't used)          |
| 031               | provider.iam.role.statements.0.Effect           | Enumeration      | Unexpected Value       | Deployment Error      | n.a.                | MalformedPolicyDocument                                                                  |
| 032               | provider.iam.role.statements.0.Resource         | PatternMustMatch | Modify Pattern         | Deployment Success    | Deployment Success  | IAM Resource pattern should not match, but resource is not used so did not cause failure |
| 033               | provider.region                                 | Enumeration      | Unexpected Value       | Deployment Error      | n.a.                |                                                                                          |
| 034               | provider.region                                 | Enumeration      | Expected but Different | Deployment Error      | n.a.                | "us-gov-west-1" region is not supported by dashboard                                     |

n=38

Some redundant deployments were not attempted (e.g. there seems to be a check for integer parameters)

