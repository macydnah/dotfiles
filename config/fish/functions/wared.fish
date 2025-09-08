function wared --wraps="watch -ctn1 'nmcli -c yes | head -n20'" --description "alias wared=watch -ctn1 'nmcli -c yes | head -n20'"
  watch -ctn1 'nmcli -c yes | head -n20' $argv
        
end
