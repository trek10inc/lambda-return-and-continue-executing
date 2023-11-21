const util = require('util')
const sleep = util.promisify(setTimeout)

// awslambda is patched into the global object by the lambda runtime
module.exports.handler = awslambda.streamifyResponse(async function(event, responseStream, context) {
  responseStream.write('Hello my request id is: ' + context.awsRequestId)
  responseStream.end();
  console.log('response sent')
  // the response has been sent and the request to lambda should return very quickly.
  // now we simulate doing some work by sleeping

  await sleep(5000)
  console.log('done waiting')
})
