# Backend Deployment Test

This test currently deploys the backend to Azure and verifies that it gets
an expected response from the server once deployed.

This test will currently be executed every time the backend changes. As this
test is expensive and slow, this is probably not desirable. We should probably
create a server as part of the fixture and deploy that as part of the test
instead of the actual backend container.

To do this we will need to separate out the infrastructure code from the
target asset in the src folder and have an additional target that adds the 
asset to the tar.

In the test code we can add a different asset to the tar that is not expected
to change frequently.