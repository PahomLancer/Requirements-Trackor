begin
    update components_package
       set is_locked = 1
     where name = 'VP - Requirements Trackor';
    dbms_output.put_line('Component Package Locked');
end;