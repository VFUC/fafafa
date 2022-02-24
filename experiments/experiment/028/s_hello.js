
var serverlessSDK = require('./serverless_sdk/index.js');
serverlessSDK = new serverlessSDK({
  orgId: 'wonas',
  applicationName: 'testbed-aws-node-http-api',
  appUid: 'YCNQRQM9NnbLDjd0DX',
  orgUid: '9d9118de-e8aa-4ae5-9881-5077d190d24b',
  deploymentUid: 'd425dcd2-ec04-4102-b1e7-73b505d41566',
  serviceName: 'aws-node-http-api',
  shouldLogMeta: true,
  shouldCompressLogs: true,
  disableAwsSpans: false,
  disableHttpSpans: false,
  stageName: 'dev',
  serverlessPlatformStage: 'prod',
  devModeEnabled: false,
  accessKey: null,
  pluginVersion: '6.0.0',
  disableFrameworksInstrumentation: false
});

const handlerWrapperArgs = { functionName: 'aws-node-http-api-dev-hello', timeout: 6 };

try {
  const userHandler = require('./handler.js');
  module.exports.handler = serverlessSDK.handler(userHandler.hello, handlerWrapperArgs);
} catch (error) {
  module.exports.handler = serverlessSDK.handler(() => { throw error }, handlerWrapperArgs);
}