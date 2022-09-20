# Configuration for spaceship ZSH prompt

# Install spaceship
zinit light spaceship-prompt/spaceship-prompt

# MARK: MISC
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)

  exec_time     # Execution time
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  time          # Time stamps section
  battery       # Battery level and status

  line_sep      # Line break
  char          # Prompt character
)

SPACESHIP_PROMPT_ASYNC=true
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=false
SPACESHIP_PROMPT_PREFIXES_SHOW=true
SPACESHIP_PROMPT_SUFFIXES_SHOW=false
SPACESHIP_PROMPT_DEFAULT_PREFIX=" · "
SPACESHIP_PROMPT_DEFAULT_SUFFIX=""

# MARK: Remove unused sectiosn
spaceship remove ruby          # Ruby section
spaceship remove python        # Python section
spaceship remove elm           # Elm section
spaceship remove elixir        # Elixir section
spaceship remove xcode         # Xcode section
spaceship remove swift         # Swift section
spaceship remove golang        # Go section
spaceship remove php           # PHP section
spaceship remove rust          # Rust section
spaceship remove haskell       # Haskell Stack section
spaceship remove java          # Java section
spaceship remove julia         # Julia section
spaceship remove docker        # Docker section
spaceship remove aws           # Amazon Web Services section
spaceship remove gcloud        # Google Cloud Platform section
spaceship remove venv          # virtualenv section
spaceship remove conda         # conda virtualenv section
spaceship remove dotnet        # .NET section
spaceship remove kubectl       # Kubectl context section
spaceship remove terraform     # Terraform workspace section
spaceship remove ibmcloud      # IBM Cloud section
spaceship remove exec_time     # Execution time
spaceship remove async         # Async jobs indicator
spaceship remove battery       # Battery level and status
spaceship remove jobs          # Background jobs indicator
spaceship remove exit_code     # Exit code section

# MARK: User
SPACESHIP_USER_SHOW=true
SPACESHIP_USER_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_USER_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_USER_COLOR="yellow"
SPACESHIP_USER_COLOR_ROOT="red"

# MARK: host
SPACESHIP_HOST_SHOW=true
SPACESHIP_HOST_SHOW_FULL=false
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_HOST_COLOR="blue"
SPACESHIP_HOST_COLOR_SSH="green"

# MARK: dir
SPACESHIP_DIR_SHOW=true
SPACESHIP_DIR_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_DIR_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_DIR_TRUNC=3
SPACESHIP_DIR_TRUNC_PREFIX="…/"
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_COLOR="blue"
SPACESHIP_DIR_LOCK_SYMBOL=""
SPACESHIP_DIR_LOCK_COLOR="red"

# MARK: Git
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_ASYNC=true
SPACESHIP_GIT_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_GIT_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_GIT_SYMBOL=""
SPACESHIP_GIT_ORDER=(git_branch git_status)

# Git Branch
SPACESHIP_GIT_BRANCH_SHOW=true
SPACESHIP_GIT_BRANCH_ASYNC=false
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_GIT_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_GIT_BRANCH_COLOR="green"

# Git status
SPACESHIP_GIT_STATUS_SHOW=true
SPACESHIP_GIT_STATUS_ASYNC=true
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_GIT_STATUS_COLOR=$SPACESHIP_GIT_BRANCH_COLOR
SPACESHIP_GIT_STATUS_UNTRACKED=""
SPACESHIP_GIT_STATUS_ADDED=""
SPACESHIP_GIT_STATUS_MODIFIED=""
SPACESHIP_GIT_STATUS_RENAMED=""
SPACESHIP_GIT_STATUS_DELETED=""
SPACESHIP_GIT_STATUS_STASHED=""
SPACESHIP_GIT_STATUS_UNMERGED=""
SPACESHIP_GIT_STATUS_AHEAD=""
SPACESHIP_GIT_STATUS_BEHIND=""
SPACESHIP_GIT_STATUS_DIVERGED=""

# MARK: exec_time
SPACESHIP_EXEC_TIME_SHOW=true
SPACESHIP_EXEC_TIME_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_EXEC_TIME_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_EXEC_TIME_COLOR="yellow"
SPACESHIP_EXEC_TIME_ELAPSED=2
SPACESHIP_EXEC_TIME_PRECISION=1

# MARK: Time
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_TIME_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_TIME_COLOR="cyan"
SPACESHIP_TIME_FORMAT="%D{%H:%M:%S}"
SPACESHIP_TIME_12HR=false

# MARK: Jobs
SPACESHIP_JOBS_SHOW=true
SPACESHIP_JOBS_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_JOBS_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_JOBS_COLOR="yellow"
SPACESHIP_JOBS_SYMBOL="✦"
SPACESHIP_JOBS_AMOUNT_PREFIX="-"
SPACESHIP_JOBS_AMOUNT_SUFFIX="-"
SPACESHIP_JOBS_AMOUNT_THRESHOLD=1

# MARK: exit_code
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_EXIT_CODE_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_EXIT_CODE_SYMBOL="✘"
SPACESHIP_EXIT_CODE_COLOR="red"

# MARK: line_sep
SPACESHIP_PROMPT_SEPARATE_LINE=true

# MARK: Battery
SPACESHIP_BATTERY_SHOW=true
SPACESHIP_BATTERY_ASYNC=true
SPACESHIP_BATTERY_PREFIX=$SPACESHIP_PROMPT_DEFAULT_PREFIX
SPACESHIP_BATTERY_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
SPACESHIP_BATTERY_SYMBOL_CHARGING=""
SPACESHIP_BATTERY_SYMBOL_DISCHARGING=""
SPACESHIP_BATTERY_SYMBOL_FULL=""
SPACESHIP_BATTERY_THRESHOLD="10"

# MARK: Char
SPACESHIP_CHAR_PREFIX=""
SPACESHIP_CHAR_SUFFIX=""
SPACESHIP_CHAR_SYMBOL="$ "
SPACESHIP_CHAR_SYMBOL_ROOT="root> "
SPACESHIP_CHAR_SYMBOL_SECONDARY="> "
SPACESHIP_CHAR_COLOR_SUCCESS="blue"
SPACESHIP_CHAR_COLOR_FAILURE="red"
SPACESHIP_CHAR_COLOR_SECONDARY="cyan"