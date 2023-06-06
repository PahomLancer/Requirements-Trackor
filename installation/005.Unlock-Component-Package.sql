begin
    update components_package
       set is_locked = 0
     where name = 'VP - Requirements Trackor';
    dbms_output.put_line('Component Package Unlocked');
end;