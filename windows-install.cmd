@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set BASE_DIR=%HOME%\.pw-vim
IF NOT EXIST "%BASE_DIR%" (
  call git clone --recursive git://github.com/perfectworks/pw-vim.git "%BASE_DIR%"
) ELSE (
	@set ORIGINAL_DIR=%CD%
    echo updating pw-vim
    chdir /d "%BASE_DIR%" 
	call git pull
    chdir /d "%ORIGINAL_DIR%"
	call cd "%BASE_DIR%" 
)

call mklink "%HOME%\.vimrc" "%BASE_DIR%\.vimrc"
call mklink "%HOME%\_vimrc" "%BASE_DIR%\.vimrc"
call mklink "%HOME%\.vimrc.fork" "%BASE_DIR%\.vimrc.fork"
call mklink "%HOME%\.vimrc.bundles" "%BASE_DIR%\.vimrc.bundles"
call mklink "%HOME%\.vimrc.bundles.fork" "%BASE_DIR%\.vimrc.bundles.fork"
call mklink /J "%HOME%\.vim" "%BASE_DIR%\.vim"

IF NOT EXIST "%BASE_DIR%\.vim\bundle" (
	call mkdir "%BASE_DIR%\.vim\bundle"
)

IF NOT EXIST "%HOME%/.vim/bundle/vundle" (
	call git clone https://github.com/gmarik/vundle.git "%HOME%/.vim/bundle/vundle"
)

call vim -u "%BASE_DIR%/.vimrc.bundles" +BundleInstall! +BundleClean +qall