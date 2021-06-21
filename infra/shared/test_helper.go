package shared

import (
	"archive/tar"
	"fmt"
	"github.com/bazelbuild/rules_go/go/tools/bazel"
	"io"
	"math/rand"
	"os"
	"path/filepath"
	"time"
)

func ExtractStackPackage(packageName string) (string, error) {
	stackPackage, err := bazel.Runfile(packageName)
	if err != nil {
		return "", fmt.Errorf("unable to find stack package [%s] (is it included in the data attribute): %v", packageName, err)
	}

	stackDir, err := bazel.NewTmpDir("stack")
	if err != nil {
		return "", fmt.Errorf("unable to create temporary directory for stack: %v", err)
	}

	err = untar(stackPackage, stackDir)
	if err != nil {
		return "", fmt.Errorf("unable to unpack stack package: %v", err)
	}

	return stackDir, nil
}

func untar(tarball, target string) error {
	reader, err := os.Open(tarball)
	if err != nil {
		return err
	}
	defer reader.Close()
	tarReader := tar.NewReader(reader)

	for {
		header, err := tarReader.Next()
		if err == io.EOF {
			break
		} else if err != nil {
			return err
		}

		path := filepath.Join(target, header.Name)
		info := header.FileInfo()
		if info.IsDir() {
			if err = os.MkdirAll(path, info.Mode()); err != nil {
				return err
			}
			continue
		}

		file, err := os.OpenFile(path, os.O_CREATE|os.O_TRUNC|os.O_WRONLY, info.Mode())
		if err != nil {
			return err
		}
		defer file.Close()
		_, err = io.Copy(file, tarReader)
		if err != nil {
			return err
		}
	}
	return nil
}

const LowerAlphaNum = "abcdefghijklmnopqrstuvwxyz1234567890"

var seededRand = rand.New(rand.NewSource(time.Now().UnixNano()))
var reservedNames = []string{"prod", "test", "dev"}

func GenerateStringWithCharset(length int, charset string) string {
	b := make([]byte, length)
	for i := range b {
		b[i] = charset[seededRand.Intn(len(charset))]
	}
	result := string(b)

	for _, item := range reservedNames {
		if item == result {
			result = GenerateStringWithCharset(length, charset)
			break
		}
	}

	return result
}
