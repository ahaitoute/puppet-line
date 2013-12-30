# http://www.puppetcookbook.com/posts/set-global-exec-path.html
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

define line($file, $line, $ensure = 'present', $comment = '#') {
  case $ensure {
    default : { err ( "unknown ensure value ${ensure}" ) }
    present: {
      exec { "echo '${line}' >> '${file}'":
        unless => "grep -qFx '${line}' '${file}'"
      }
    }
    absent: {
      exec { "grep -vFx '${line}' '${file}' | tee '${file}' > /dev/null 2>&1":
        onlyif => "grep -qFx '${line}' '${file}'"
      }
    }
    uncomment: {
      exec { "sed -i -e'/${line}/s/${comment}\\+//' '${file}'" :
        onlyif => "grep '${line}' '${file}' | grep '^${comment}' | wc -l"
      }
    }
    comment: {
      exec { "sed -i -e'/${line}/s/\\(.\\+\\)$/${comment}\\1/' '${file}'" :
        onlyif => "test `grep '${line}' '${file}' | grep -v '^${comment}' | wc -l` -ne 0"
      }
    }
  }
}
