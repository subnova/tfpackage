package terraform_test

import (
	"github.com/bazelbuild/rules_go/go/tools/bazel"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"path/filepath"
	"testing"
)

func TestTerraformValid(t *testing.T) {
	runfiles, err := bazel.ListRunfiles()
	if err != nil {
		t.Fatal("unable to find runfiles")
	}
	var tfPath string
	var tfBinary string
	for _, runfile := range runfiles {
		if filepath.Ext(runfile.Path) == ".tf" {
			tfPath = filepath.Dir(runfile.Path)
		}
		if filepath.Base(runfile.Path) == "terraform" {
			tfBinary = runfile.Path
		}
	}
	if tfBinary == "" {
		t.Fatal("unable to find terraform binary, is it passed as a data element?")
	}
	if tfPath == "" {
		t.Fatal("unable to find terraform files to test, are they passed as a data element?")
	}

	options := terraform.Options{
		TerraformDir: tfPath,
		TerraformBinary: tfBinary,

		NoColor: true,
	}

	terraform.InitAndValidate(t, &options)
}
