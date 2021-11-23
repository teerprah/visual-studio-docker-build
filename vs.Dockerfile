FROM mcr.microsoft.com/windows/servercore:ltsc2019
SHELL ["powershell"]


# choco
RUN iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))


# Dotnet4.8 developer pack
RUN Start-BitsTransfer -Source 'https://go.microsoft.com/fwlink/?linkid=2088517'  -Destination "$Env:Temp\Net4.8-devpack.exe"; & "$Env:Temp\Net4.8-devpack.exe" /q /norestart

# VS2019
RUN choco install -y visualstudio2019community --includeRecommended

# msbuild
RUN & 'C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/MSBuild/Current/Bin/MSBuild.exe' /version


# 7zip
RUN choco install -y 7zip.install

# NUnit
RUN choco install -y nunit-console-runner

# git
RUN choco install -y git
RUN git --version --build-options

# nuget
RUN choco install -y nuget.commandline
RUN nuget help

CMD ["powershell"]
