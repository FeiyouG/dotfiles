# Configuration for spaceship ZSH prompt

# Install spaceship
zinit light spaceship-prompt/spaceship-prompt

# Order
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  gradle        # Gradle section
  maven         # Maven section
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  ibmcloud      # IBM Cloud section
  exec_time     # Execution time
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  time          # Time stamps section
  battery       # Battery level and status
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  char          # Prompt character
)

# Helper Variables
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
SPACESHIP_PROMPT_DEFAULT_PREFIX=" · "
SPACESHIP_PROMPT_DEFAULT_SUFFIX=""

# Prompt
SPACESHIP_CHAR_SYMBOL="$ "
SPACESHIP_CHAR_COLOR_SUCCESS="blue"
SPACESHIP_CHAR_SYMBOL_SECONDARY="> "
SPACESHIP_CHAR_COLOR_SECONDARY="cyan"

# User
SPACESHIP_USER_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_USER_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX

# Host
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX

# Time
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_COLOR="cyan"
SPACESHIP_TIME_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_TIME_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX

# Directory
SPACESHIP_DIR_TRUNC=3
SPACESHIP_DIR_COLOR="blue"
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_TRUNC_PREFIX="…/"
SPACESHIP_DIR_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_DIR_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX

# Git
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_BRANCH_COLOR="green"
SPACESHIP_GIT_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_GIT_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX

SPACESHIP_GIT_STATUS_COLOR=$SPACESHIP_GIT_BRANCH_COLOR
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_GIT_STATUS_STASHED="≡"
SPACESHIP_GIT_STATUS_UNMERGED=""

# Execution Time
SPACESHIP_EXEC_TIME_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_EXEC_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX

# Battery
SPACESHIP_BATTERY_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_BATTERY_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_BATTERY_SYMBOL_CHARGING=""
SPACESHIP_BATTERY_SYMBOL_DISCHARGING=""
SPACESHIP_BATTERY_SYMBOL_FULL=""

# Background Jobs
SPACESHIP_JOBS_SHOW=true
SPACESHIP_JOBS_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_JOBS_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_JOBS_COLOR="syan"

# Exit code
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_EXIT_CODE_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX

# Disabled
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_ELM_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_HASKELL_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_DOCKER_CONTEXT_SHOW=false
SPACESHIP_AWS_SHOW=false
SPACESHIP_GCLOUD_SHOW=false
SPACESHIP_VENV_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECTL_SHOW=false
SPACESHIP_KUBECTL_VERSION_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_GRADLE_SHOW=false
SPACESHIP_MAVEN_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_IBMCLOUD_SHOW=false
