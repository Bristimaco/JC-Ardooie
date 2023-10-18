tableextension 50102 "JCA Customer" extends Customer
{
    fields
    {
        field(50100; "JCA Sponsor"; Boolean)
        {
            Caption = 'Sponsor';
            DataClassification = SystemMetadata;
        }
    }
}