permissionset 50100 "Judo Manager"
{
    Assignable = true;
    Permissions = tabledata "JCA Action Log"=RIMD,
        tabledata "JCA Age Group"=RIMD,
        tabledata "JCA Club"=RIMD,
        tabledata "JCA Contact"=RIMD,
        tabledata "JCA Cue"=RIMD,
        tabledata "JCA Event"=RIMD,
        tabledata "JCA Event Age Group"=RIMD,
        tabledata "JCA Event Document"=RIMD,
        tabledata "JCA Event Participant"=RIMD,
        tabledata "JCA Event Supervisor"=RIMD,
        tabledata "JCA Guest Member"=RIMD,
        tabledata "JCA Guest Member Tr. Group"=RIMD,
        tabledata "JCA HTML Gen. CSS Template"=RIMD,
        tabledata "JCA Injury"=RIMD,
        tabledata "JCA Mail Message Template"=RIMD,
        tabledata "JCA Member"=RIMD,
        tabledata "JCA Member Age Group"=RIMD,
        tabledata "JCA Member Contact"=RIMD,
        tabledata "JCA Membership"=RIMD,
        tabledata "JCA Membership Period"=RIMD,
        tabledata "JCA Result Image"=RIMD,
        tabledata "JCA Setup"=RIMD,
        tabledata "JCA Tr. Session Participant"=RIMD,
        tabledata "JCA Training Group"=RIMD,
        tabledata "JCA Training Group Member"=RIMD,
        tabledata "JCA Training Session"=RIMD,
        tabledata "JCA Voucher"=RIMD,
        tabledata "JCA Voucher Type"=RIMD,
        tabledata "JCA Weight Group"=RIMD,
        table "JCA Action Log"=X,
        table "JCA Age Group"=X,
        table "JCA Club"=X,
        table "JCA Contact"=X,
        table "JCA Cue"=X,
        table "JCA Event"=X,
        table "JCA Event Age Group"=X,
        table "JCA Event Document"=X,
        table "JCA Event Participant"=X,
        table "JCA Event Supervisor"=X,
        table "JCA Guest Member"=X,
        table "JCA Guest Member Tr. Group"=X,
        table "JCA HTML Gen. CSS Template"=X,
        table "JCA Injury"=X,
        table "JCA Mail Message Template"=X,
        table "JCA Member"=X,
        table "JCA Member Age Group"=X,
        table "JCA Member Contact"=X,
        table "JCA Membership"=X,
        table "JCA Membership Period"=X,
        table "JCA Result Image"=X,
        table "JCA Setup"=X,
        table "JCA Tr. Session Participant"=X,
        table "JCA Training Group"=X,
        table "JCA Training Group Member"=X,
        table "JCA Training Session"=X,
        table "JCA Voucher"=X,
        table "JCA Voucher Type"=X,
        table "JCA Weight Group"=X,
        report "JCA Event Refunds"=X,
        report "JCA Event Report"=X,
        codeunit "JCA Action Log Management"=X,
        codeunit "JCA Automated Tasks"=X,
        codeunit "JCA Event Inv. Reminder Mail"=X,
        codeunit "JCA Event Invitation Mail"=X,
        codeunit "JCA Event Management"=X,
        codeunit "JCA Event Registration Mail"=X,
        codeunit "JCA Event Result Mail"=X,
        codeunit "JCA Event Unregistration Mail"=X,
        codeunit "JCA HTML Generator"=X,
        codeunit "JCA Install"=X,
        codeunit "JCA Mail System Helper"=X,
        codeunit "JCA Member Management"=X,
        codeunit "JCA Send Result Mails"=X,
        codeunit "JCA Training Management"=X,
        page "JCA Action Logs"=X,
        page "JCA Admin Rolecenter"=X,
        page "JCA Age Groups"=X,
        page "JCA Clubs"=X,
        page "JCA Contacts"=X,
        page "JCA Event Age Group Lookup"=X,
        page "JCA Event Age Groups"=X,
        page "JCA Event Card"=X,
        page "JCA Event Cues"=X,
        page "JCA Event Documents"=X,
        page "JCA Event Inv. Mail Editor"=X,
        page "JCA Event Participants"=X,
        page "JCA Event Result Mail Editor"=X,
        page "JCA Event Supervisor Sheet"=X,
        page "JCA Event Supervisors"=X,
        page "JCA Events"=X,
        page "JCA Guest Member Card"=X,
        page "JCA Guest Member Tr. Groups"=X,
        page "JCA Guest Members"=X,
        page "JCA HTML Gen. CSS Editor"=X,
        page "JCA HTML Gen. CSS Templates"=X,
        page "JCA Mail Message Templates"=X,
        page "JCA Member Age Groups"=X,
        page "JCA Member Card"=X,
        page "JCA Member Contacts"=X,
        page "JCA Member Cues"=X,
        page "JCA Member Factbox"=X,
        page "JCA Member Training Groups"=X,
        page "JCA Members"=X,
        page "JCA Membership Periods"=X,
        page "JCA Memberships"=X,
        page "JCA Result Image Factbox"=X,
        page "JCA Result Images"=X,
        page "JCA Setup"=X,
        page "JCA Setup Factbox"=X,
        page "JCA Today Cues"=X,
        page "JCA Tr. Session Participants"=X,
        page "JCA Training Attendance"=X,
        page "JCA Training Group Members"=X,
        page "JCA Training Groups"=X,
        page "JCA Training Session Card"=X,
        page "JCA Training Session Cues"=X,
        page "JCA Training Sessions"=X,
        page "JCA Voucher Types"=X,
        page "JCA Vouchers"=X,
        page "JCA Weight Groups"=X,
        tabledata "JCA Sponsor Formula"=RIMD,
        table "JCA Sponsor Formula"=X,
        codeunit "JCA Grouped Event Result Mail"=X,
        codeunit "JCA Voucher Management"=X,
        page "JCA Gr. Ev. Res. Mail Editor"=X,
        page "JCA Injuries"=X,
        page "JCA Injury Card"=X,
        page "JCA Sponsor Formulas"=X,
        tabledata "JCA Sponsorship Period"=RIMD,
        table "JCA Sponsorship Period"=X,
        codeunit "JCA Sponsor Management"=X,
        page "JCA Sponsorship Periods"=X,
        tabledata "JCA PDF Viewer Setup"=RIMD,
        tabledata "PDF Viewer Buffer"=RIMD,
        table "JCA PDF Viewer Setup"=X,
        table "PDF Viewer Buffer"=X,
        codeunit "JCA Get PDF Data"=X,
        codeunit "JCA Open PDF Viewer"=X,
        page "JCA PDF Viewer"=X,
        page "JCA PDF Viewer Part"=X,
        page "JCA PDF Viewer Setup"=X,
        page "JCA Sponsor Cues"=X,
        page "JCA Voucher Cues"=X;
}