# initialize starship for themes
eval "$(starship init zsh)" > /tmp/log.txt

# zsh completions
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit

#echo -e "\e[93mH\e[91me\e[92ml\e[96ml\e[94mo\e[0m"

# exports
export PATH_TO_FX=/Users/junaadh/.sdk/javafx-sdk-21.0.1/lib
export PATH="$PATH:/Users/junaadh/.local/bin"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home
export PATH="$PATH:/Library/TeX/texbin/pdflatex"
# export PATH="$PATH:/Users/junaadh/.sdk/flutter/in"
# export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

## java
# define custom alias for running java files
alias runjava='run_java'

#define custom function
run_java() {
  local isNotJavaFx=$(grep -q "javafx" ./pom.xml && echo false || echo true)
  local groupId=$(grep -m1 -E groupId ./pom.xml | sed -n 's/.*<groupId>\(.*\)<\/groupId>.*/\1/p')
  local package=$(echo $groupId | sed 's/\./\//g')
  local artifactId=$(grep -m1 -E artifactId pom.xml | sed -n 's/.*<artifactId>\(.*\)<\/artifactId>.*/\1/p')
  local classes="target/classes"
  local defaultArgs="-XX:+ShowCodeDetailsInExceptionMessages"

  if [ $# -eq 0 ]; then
    echo "runjava <MAIN_CLASS>"
  fi
  
  if [ -e "./src/main/java/$package" ]; then
    /usr/bin/find "./src/main/java/$package" -name "*.java" -exec /usr/bin/javac -d "./$classes" {} +
  else
    /usr/bin/find "./src/main/java/$artifactId" -name "*.java" -exec /usr/bin/javac -d "./$classes" {} +
  fi
  
  if $isNotJavaFx; then
    /usr/bin/env $JAVA_HOME/bin/java $defaultArgs -cp ./$classes $package.$1  
    return 0
  else
    local modules=$(grep -E 'requires' ./src/main/java/module-info.java | awk '{ sub(/;$/, ""); print $NF }' | cut -d '.' -f2)
    local count=$(echo $modules | wc -w)
    local classpath="/Users/junaadh/.m2/repository/org/openjfx/javafx-base/20.0.1/javafx-base-20.0.1.jar"
    local modulepath="$PWD/$classes:/Users/junaadh/.m2/repository/org/openjfx/javafx-base/20.0.1/javafx-base-20.0.1-mac-aarch64.jar"

    for ((i=1; i<=$count; i++)); do
      module=$(echo $modules | sed -n "$i"p)
      classpath="$classpath:$HOME/.m2/repository/org/openjfx/javafx-$module/21.0.1/javafx-$module-21.0.1.jar"
      modulepath="$modulepath:/Users/junaadh/.m2/repository/org/openjfx/javafx-$module/20.0.1/javafx-$module-20.0.1-mac-aarch64.jar"
    done

    if [[ $(echo $modules | grep "web" | echo true) ]]; then
      classpath="$classpath:/Users/junaadh/.m2/repository/org/openjfx/javafx-media/20.0.1/javafx-media-20.0.1.jar"
      modulepath="$modulepath:/Users/junaadh/.m2/repository/org/openjfx/javafx-media/20.0.1/javafx-media-20.0.1-mac-aarch64.jar"
    fi
    
    /usr/bin/env $JAVA_HOME/bin/java $defaultArgs -cp $classpath --module-path $modulepath -m $artifactId/$artifactId.$1
  fi
}

#define alias for building mvn project
alias create-mvn='create-maven-project'

#define custom function
create-maven-project() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: create-maven-project <groupId> <artifactId>"
    return 1
  fi

   local groupId="$1"
   local artifactId="$2"
   local groupIdPath="${groupId//.//}"
   local baseDir="$PWD/$artifactId"

   # Create project directories and files
   mkdir -p "$baseDir/src/main/java/$groupIdPath"
   mkdir -p "$baseDir/src/test/java/$groupIdPath"
   touch "$baseDir/src/main/java/$groupIdPath/App.java"
   touch "$baseDir/src/test/java/$groupIdPath/AppTest.java"
   mkdir -p "$baseDir/target/classes/$groupIdPath"
   mkdir "$baseDir/target/test-classes"
   
   touch "$baseDir/pom.xml"
   echo '<?xml version="1.0" encoding="UTF-8"?>' > "$baseDir/pom.xml"
   echo '<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">' >> "$baseDir/pom.xml"
   echo '    <modelVersion>4.0.0</modelVersion>' >> "$baseDir/pom.xml"
   echo '' >> "$baseDir/pom.xml"
   echo "    <groupId>$groupId</groupId>" >> "$baseDir/pom.xml"
   echo "    <artifactId>$artifactId</artifactId>" >> "$baseDir/pom.xml"
   echo '    <version>1.0-SNAPSHOT</version>' >> "$baseDir/pom.xml"
   echo '' >> "$baseDir/pom.xml"
   echo '    <properties>' >> "$baseDir/pom.xml"
   echo '        <maven.compiler.source>1.8</maven.compiler.source>' >> "$baseDir/pom.xml"
   echo '        <maven.compiler.target>1.8</maven.compiler.target>' >> "$baseDir/pom.xml"
   echo '    </properties>' >> "$baseDir/pom.xml"
   echo '</project>' >> "$baseDir/pom.xml"

   echo "package $groupId;" > "$baseDir/src/main/java/$groupIdPath/App.java"
   echo '' >> "$baseDir/src/main/java/$groupIdPath/App.java" 
   echo 'public class App {' >> "$baseDir/src/main/java/$groupIdPath/App.java"
   echo '  public static void main(String[] args) {' >> "$baseDir/src/main/java/$groupIdPath/App.java"
   echo '    System.out.println("Hello World!");' >> "$baseDir/src/main/java/$groupIdPath/App.java"
   echo '  }' >> "$baseDir/src/main/java/$groupIdPath/App.java"
   echo '}' >> "$baseDir/src/main/java/$groupIdPath/App.java"
   
  echo "Maven project '$artifactId' with groupId '$groupId' created in '$baseDir'."
}

# define custom alias for creating java files
alias mkjfl='make-java-file'

make-java-file() { 
  local current_dir="$PWD"
  local pom_file="./pom.xml"

  while [ ! -f "$pom_file" ] && [ "$current_dir" != "/" ]; do
    current_dir=$(dirname "$current_dir")
    pom_file="$current_dir/pom.xml"
  done

  if [ ! -f "$pom_file" ]; then
    echo "Error: The pom.xml file was not found in the current directory or any parent directories."
    return 1
  fi

   local package_name
   package_name=$(grep -m 1 -E groupId "$pom_file" | cut -d'<' -f2 | cut -d'>' -f2)

   if [ -z "$package_name" ]; then
     echo "Error: Package name not found in the pom.xml file."
     return 1
  fi

  if [ $# -ne 1 ]; then
    echo "Usage: make-java-file <ClassName>"
    return 1
  fi

  local filename="$1"
  local name=$(echo "$filename" | cut -d'.' -f1)

  if [ -f "$filename" ]; then
    echo "Error: The file '$full_path' already exists."
    return 1
  fi
    
  touch "$filename"
  echo "package $package_name;" > "$filename"
  echo " " >> "$filename"
  echo "public class $name {" >> "$filename"
  echo " " >> "$filename"
  echo "}" >> "$filename"
}

## cpp
# build cpp binary
alias buildcpp='build-cpp'

# build and run cpp binary
alias runcpp='build-and-run-cpp'

build-cpp() {
  local name="$1"
  local binary=$(echo "$name" | cut -d'.' -f1)

  if [ -f "$binary" ]; then
    echo "Overwriting $binary! \n"
  fi
  
  g++ "$name" -o "$binary"
}

build-and-run-cpp() {
  if [ "$#" -eq 0 ]; then
    echo "USAGE: runcpp <program.cpp>"
    return 1
  fi
  
  local name="$1"
  local binary=$(echo "$name" | cut -d'.' -f1)
    
  # Call buildcpp to compile the C++ source file
  build-cpp "$name"

  # Check if the compilation was successful
  if [ $? -eq 0 ]; then
     # Run the compiled binary with the same name as the source file
     "./$binary"
  else
      echo "Compilation failed for $binary.cpp"
  fi
}

# create cpp file with basic skeleton
alias mkcpfl='create-cpp'

create-cpp() {
  local filename="$1"
  local binary=$(echo "$filename" | cut -d'.' -f1)

  if [ -f '$filename' ]; then
    echo "File already exists"
    return 1
  fi

  touch "$filename"
  echo "#include <iostream>" > "$filename"
  echo "using namespace std;" >> "$filename"
  echo " " >> "$filename"
  echo "int main() {" >> "$filename"
  echo '  cout << "Hello World!" << endl;' >> "$filename"
  echo "  return 0;" >> "$filename"
  echo "}" >> "$filename"
}

## c
# build c
alias buildc='build_c'

build_c() {
  local filename="$1"
  local binary=$(echo "$filename" | cut -d'.' -f1)

  if [ -f "$binary" ]; then
    echo "Overwriting $binary! \n"
  fi
  
  gcc -Wall -Wextra -std=c2x -pedantic "$filename" -o "$binary"
}

# build and run c
alias runc='build_and_run_c'

build_and_run_c() {
  local filename="$1"
  local binary=$(echo "$filename" | cut -d'.' -f1 )

  build_c "$filename"
  if [ "$?" -eq 0 ]; then
    "./$binary"
  else
    echo "Compilation of $binary failed"
  fi
}

# create c file with basic syntax
alias mkcfl='create_c'

create_c() {
  local filename="$1"
  local binary=$(echo "$filename" | cut -d'.' -f1)

  if [ -f "$filename" ]; then
    echo "File "$filename" already exists"
    return 1
  fi

  touch "$filename"
  echo "#include <stdio.h>" > "$filename"
  echo " " >> "$filename"
  echo "int main(void) {" >> "$filename"
  echo '  printf("Hello World\\n");' >> "$filename"
  echo "  return 0;" >> "$filename"
  echo "}" >> "$filename"
}

## assembly
# run asm files
alias runasm='run-asm'

run-asm() {
  declare -a src_files
  local debug=""
  local binary=""
  local sdk=$(xcrun -sdk macosx --show-sdk-path)
   
  while [[ $# -gt 0 ]]; do 
    case "$1" in
      -d)
        debug="-g"
        shift
        ;;
      *.s)
        src_files+=("$1")
        shift
        ;;
      *)
        binary="$1"
        shift
        ;;
    esac
  done

  local file_count=$(echo ${src_files[@]} | wc -w)

  if [ $file_count -eq 0 ]; then
    echo "No source files provided. Usage: runasm [options] <source-file.s> [<output-binary>]"
    return
  elif [ $file_count -eq 1 ]; then
    local filename=${src_files[1]}
    binary=$(echo "$filename" | cut -d'.' -f1)


        as -arch arm64 $debug -o $binary.o $filename
    ld -o $binary $binary.o -lSystem -syslibroot $sdk -e _start
    ./$binary
  else
    for src_file in "${src_files[@]}"; do
      local base_name="${src_file%.s}"

      as -arch arm64 $debug -o "$base_name.o" "$src_file"
    done
    for ((i=1; i<=$file_count; i++)); do
      src_files[$i]="${src_files[$i]%.s}.o"
    done

    ld -o "$binary" "${src_files[@]%.s}" -lSystem -syslibroot $sdk -e _start
    ./"$binary"
  fi
}

# remove compiled binary and .o
alias cleanasm='clean-asm'

clean-asm() {
  local binary=$(exa | grep '\.s' | cut -d'.' -f1)
  local count=$(echo $binary | wc -w)

  for ((i=1; i<=$count; i++)); do
    file_name=$(echo $binary | sed -n "$i"p)
    echo "Cleaning... $file_name.s binaries..."
    rm -f "$file_name" $file_name.o
  done
}

# show ascii dump in hex
alias dump='od -t x1 -A n $1'

## misc aliases
# developer folder
alias devenv='dev-env'

# Define the 'devenv' function
dev-env() {
  local dev="$HOME/Developer"
  
  if [ $# -eq 0 ]; then
    cd $dev
  else
    cd "$dev/$1"
  fi
}

_dev() {
  _files -W $HOME/Developer/
  zstyle ':completion:*:*files' ignored-patterns '*?.*?' '.*[^/]'
}

compdef _dev dev-env

# Set up tab completions for 'devenv' function

# # Acadamics folder
alias acadenv='acad-env'

acad-env() {
  local acad="$HOME/Documents/Acadamics/sem3"

  if [ "$#" -eq 0 ]; then
    cd "$acad"
  else
    cd "$acad/$1"
  fi
}

_acad_completion() {
  _files -W /Users/junaadh/Documents/Acadamics/sem3/
}

compdef _acad_completion acad-env

# dev setup
alias dev='open-dev'

open-dev() {
  local search="$1"
  local dev="$HOME/Developer"
  local dir=$(find $dev -type d -name $search)

  if [ -n "$dir" ]; then
    cd "$dir" || echo "Error: Unable to change dir to $dir"
    hx .
    # open -a iTerm .
    osascript -e 'tell application "System Events" to key code 123 using {control down, option down}'
    osascript -e 'tell application "System Events" to key code 45 using command down'
    osascript -e 'tell application "System Events" to keystroke "`" using command down'
    ls src -T --level=4
    osascript -e 'tell application "System Events" to key code 34 using {control down, option down}'
    osascript -e 'tell application "System Events" to key code 45 using command down'
    osascript -e 'tell application "System Events" to keystroke "`" using command down'
    echo "Terminal for doing stuff"
    osascript -e 'tell application "System Events" to key code 40 using {control down, option down}'
  else
    echo "Error: Directory with name $search not found in directory $dev"
  fi
}

# Edit .zshrc
alias hxz='hx ~/.zshrc'

# Edit zellij conf
alias hxj='hx ~/.config/zellij/config.kdl'

# Edit tmux conf
alias hxt='hx ~/.config/tmux/tmux.conf'

# tmux
alias tmuxnew='tmux new -s'

# Edit hx config
alias hxc='aconf'

aconf() {
  local path='~/.config/helix'

  if [ "$#" -eq 0 ]; then
    /opt/homebrew/bin/hx "$path/config.toml"
  fi

  local file="$1"

  if [ "$file" = 'l' ]; then
    /opt/homebrew/bin/hx "$path/languages.toml"
  fi 
}

# refresh zshconfig
alias refresh='source ~/.zshrc'

# clear screen
alias cls='clear'

# replace ls with exa
alias ls='exa --icons'

## Git alias

alias gs='git status'
alias upgit='git_deploy'

git_deploy() {
  if [ "$#" -eq 0 ]; then
    echo "USAGE: upgit <commit_message> <branch>?"
    return 1
  fi
  
  local commit="$1"

  git add .
  git commit -m "$commit"

  if [ "$#" -eq 2 ]; then
    local branch="$2"
    
    git push origin "$branch"
  fi

  git push
}

## brew alias

alias search='brew search'
alias install='brew install'
alias uninstall='brew uninstall'
alias list='brew list'
alias clean='brew autoremove && brew cleanup'
alias update='brew update && brew upgrade'

## qemu
# run qemu with raw image/bin
alias vmrun="qemu-system-x86_64 -L /Applications/UTM.app/Contents/Resources/qemu"

## osascript
# grep all keys and there values in osx
# alias keydef='grep '^ *kVK' /Library/Developer/CommandLineTools/SDKs/MacOSX14.0.sdk/System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/Headers/Events.h | tr -d , | while read x y z;do printf '%d %s %s\n' $z $z ${x#kVK_};done | sort -n'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
