# Copyright 2026 The Jule Project Contributors. All rights reserved.
# Use of this source code is governed by a BSD 3-Clause
# license that can be found in the LICENSE file.

# Create a workspace to build a release.
mkdir ./jule-workspace
cd ./jule-workspace

# Get source code from the master branch and setup the environment.
curl -L -o jule.zip https://github.com/julelang/jule/archive/refs/heads/master.zip
7zz x ./jule.zip
rm ./jule.zip
mv ./jule-master ./jule
cd ./jule
mkdir ./bin

# Get ARM64 IRs from the GitHub and compile it.
curl -L -o ir.cpp https://raw.githubusercontent.com/julelang/julec-ir/main/src/darwin-arm64.cpp
curl -fsSL https://raw.githubusercontent.com/julelang/julec-ir/refs/heads/main/meta/darwin-arm64.txt | bash

# Create tar.xz for release.
cd ..
7zz a -ttar -xr'!*.DS_Store' -xr'!__MACOSX' jule-darwin-arm64.tar jule
7zz a -txz jule-darwin-arm64.tar.xz jule-darwin-arm64.tar
rm jule-darwin-arm64.tar

# Clean environment for AMD64.
cd ./jule
rm ./bin/julec
rm ./ir.cpp

# Get AMD64 IRs from the GitHub and compile it.
curl -L -o ir.cpp https://raw.githubusercontent.com/julelang/julec-ir/main/src/darwin-amd64.cpp
curl -fsSL https://raw.githubusercontent.com/julelang/julec-ir/refs/heads/main/meta/darwin-amd64.txt | bash

# Create tar.xz for release.
cd ..
7zz a -ttar -xr'!*.DS_Store' -xr'!__MACOSX' jule-darwin-amd64.tar jule
7zz a -txz jule-darwin-amd64.tar.xz jule-darwin-amd64.tar
rm jule-darwin-amd64.tar

# Clear the workspace.
rm -r ./jule