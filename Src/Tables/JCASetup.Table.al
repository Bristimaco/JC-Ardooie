table 50100 "JCA Setup" 
{
    Caption = 'Setup';

    fields
    {
        field(1;Code;code[10])
        {
            Caption = 'Code';
            DataClassification =SystemMetadata;
        }
    }

    keys
    {
        key(PK;Code)
        {}
    }
}