pageextension 50104 "JCA Post Codes" extends "Post Codes"
{
    layout
    {
        modify(County)
        {
            Visible = false;
        }
        modify(TimeZone)
        {
            Visible = false;
        }
    }
}