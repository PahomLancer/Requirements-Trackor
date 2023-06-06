begin
    for rec in (
        select rule_id, rule, sql_text
          from rule
         where rule in (
             'VPRT Set Requirement Created Date', 
             'VPRT Update Requirements Comment History', 
             'VPRT Copy Comments to Chat', 
             'VPRT Set Requirement Created By', 
             'VPRT Copy Chat to Comments Field', 
             'VPRT Create OV Change Request'
        )
    ) loop
        dbms_output.put_line('Enabling rule [' ||  rec.rule || ']' || pkg_str.c_lb);
        pkg_ruleator.compile_rule_plsql_block_and_raise(rec.sql_text);
        update rule set is_enabled = 1 where rule_id = rec.rule_id;
        commit;
    end loop;
    dbms_output.put_line('Rules Enabled' || pkg_str.c_lb);
    update autom
       set enabled = 1
     where autom_name in (
     'VPRT REQ_PROD_RLSD_DATE', 
     'VPRT REQ_RELEASE_TO_ONEVIZION_DATE', 
     'VPRT REQ_REQUIREMENT_ACCEPTED_DATE',
     'VPRT REQ_RELEASE_TO_ONEVIZION new', 
     'VPRT REQ_ADDITIONAL_DETAIL_NEEDED', 
     'VPRT REQ_READY_TO_TEST',
     'VPRT REQ_ADDITIONAL_DETAIL_NEEDED1', 
     'VPRT REQ_ESTIMATE_ACCEPTED_DATE', 
     'VPRT REQ_REQUIREMENT_ACCEPTED',
     'VPRT REQ_READY_TO_TEST_DATE', 
     'VPRT REQ_ESTIMATE_TO_CUSTOMER_DATE', 
     'VPRT REQ_RELEASE_TO_ONEVIZION old',
     'VPRT REC_ACTUAL_COMPLETE', 
     'VPRT I_ISTATUS', 
     'VPRT REQ_REQUIREMENT_STATUS_CHANGE_',
     'VPRT REQ_ADDITIONAL_DETAIL_REQ_DATE', 
     'VPRT REQ_REQ_ACCEPTED_UAT_DATE', 
     'VPRT REQ_PRODUCTION_RELEASED',
     'VPRT REQ_READY_TO_TEST 2',
     'VPRT I_OWNER'
    );
    dbms_output.put_line('Automations Enabled');
end;
