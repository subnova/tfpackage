# Backend Deployment Test

This test verifies that the infrastructure code is able to deploy a container
to Azure. The test uses a test container as part of its test fixture to ensure
the test isn't coupled to the actual backend image we will
deploy. This is because the backend image will change frequently causing this 
test to re-run when none of the infrastructure code has actually changed. As a
result we will not pick up issues where some change to the backend image somehow
invalidates the infrastructure code - but that is not what this test is for.