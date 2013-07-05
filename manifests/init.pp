define line($file, $line, $ensure = 'present', $comment = '#') {
  case $ensure {
    default : { err ( "unknown ensure value ${ensure}" ) }
    present: {
      exec { "/bin/echo '${line}' >> '${file}'":
        unless => "/bin/grep -qFx '${line}' '${file}'"
      }
    }
    absent: {
      exec { "/bin/grep -vFx '${line}' '${file}' | /usr/bin/tee '${file}' > /dev/null 2>&1":
        onlyif => "/bin/grep -qFx '${line}' '${file}'"
      }
    }
    uncomment: {
      exec { "/bin/sed -i -e'/${line}/s/${comment}\+//' '${file}'" :
        onlyif => "/bin/grep '${line}' '${file}' | /bin/grep '^${comment}' | /usr/bin/wc -l"
      }
    }
    comment: {
      exec { "/bin/sed -i -e'/${line}/s/\(.\+\)$/${comment}\1/' '${file}'" :
        onlyif => "/usr/bin/test `/bin/grep '${line}' '${file}' | /bin/grep -v '^${comment}' | /usr/bin/wc -l` -ne 0"
      }
    }
  }
}
