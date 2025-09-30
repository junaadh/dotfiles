# conf create
#
# easy shorthand for creating files inside $env.config-dir
export def "conf create" [
  name: string
] {
  touch $"($nu.default-config-dir)/($name)"
}

export def dev_completions [
  context: string = ""
] {
  let dev_dir = $"($env.HOME)/Developer"
  let term = ($context | split words | last)

  ls $dev_dir
  | where type == "dir"
  | each {
    ls $in.name | where type == "dir"
  }
  | flatten
  | filter {|entry| ( $entry.name | path basename | str starts-with $term ) }
  | get name
  | path basename 
}

# dev
#
# easy shorthand command for navigating to development environment
export def --env dev [
  search_term?: string@dev_completions  # the name of the project
] {
  let dev_dir = $"($env.HOME)/Developer"

  if $search_term != null {
    let dirs = (
      ls $dev_dir
      | where type == "dir"
      | each {
        ls $in.name | where type == "dir"
      }
      | flatten
      | filter {|entry| ( $entry.name | path basename | str starts-with $search_term ) }
      | get name
    )

    if ($dirs | length) > 0 {
      cd ($dirs | first)
    } else {
      print $"Error: ($search_term) not found in ($dev_dir)"
    }
    
  } else {
    cd $dev_dir
  }

}
