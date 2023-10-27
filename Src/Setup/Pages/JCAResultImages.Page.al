page 50136 "JCA Result Images"
{
    Caption = 'Result Images';
    PageType = List;
    SourceTable = "JCA Result Image";
    Editable = false;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(ResultImages)
            {
                field(Result; Rec.Result)
                {
                    ApplicationArea = all;
                    ToolTip = ' ', Locked = true;
                }
            }
        }

        area(FactBoxes)
        {
            part(Image; "JCA Result Image Factbox")
            {
                ApplicationArea = all;
                SubPageLink = Result = field(Result);
                UpdatePropagation = both;
            }
        }
    }
}