package test

import (
	"fmt"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/subnova/tfpackage/infra/shared"
	"path"
	"testing"
	"time"
)

func TestBackendAppStack(t *testing.T) {
	stackDir, err := shared.ExtractStackPackage("bundle.tar")
	if err != nil {
		t.Fatal(err)
	}

	terraformBinary := path.Join(stackDir, "terraform")
	envName := shared.GenerateStringWithCharset(5, shared.LowerAlphaNum)

	// provider fixture
	terraformProviderFixtureOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: ".",
		TerraformBinary: terraformBinary,

		Vars: map[string]interface{}{
			"env": envName,
		},

		EnvVars: map[string]string{
			"AZURE_LOGGING_ENABLE_LOG_FILE": "false",
		},

		NoColor: true,
	})
	defer terraform.Destroy(t, terraformProviderFixtureOptions)

	terraform.InitAndApply(t, terraformProviderFixtureOptions)

	// code under test
	vars := terraform.OutputAll(t, terraformProviderFixtureOptions)
	vars["env"] = envName
	vars["local_image_name"] = "bazel/infra/apps/backend/test/container_fixture:docker"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:    stackDir,
		TerraformBinary: terraformBinary,

		Vars: vars,

		EnvVars: map[string]string{
			"AZURE_LOGGING_ENABLE_LOG_FILE": "false",
		},

		RetryableTerraformErrors: map[string]string{".*": "Azure is flaky"},
		MaxRetries: 2,
		TimeBetweenRetries: 5*time.Second,

		NoColor: true,
	})
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// verify that we can connect to the backend
	backendHostName := terraform.Output(t, terraformOptions, "backend")
	assert.NotEmpty(t, backendHostName)

	url := fmt.Sprintf("http://%s", backendHostName)
	http_helper.HttpGetWithRetry(t, url, nil, 200, "Hello World!", 10, 5 * time.Second)
}
