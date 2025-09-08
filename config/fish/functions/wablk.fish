function wablk --wraps="watch -ctn1 'echo ; lsblk'" --description "alias wablk=watch -ctn1 'echo ; lsblk'"
  watch -ctn1 'echo ; lsblk' $argv
        
end
