page 50100 "Miracle Fixes"
{
    Caption = 'Miracle Fixes';
    PageType = Card;
    SourceTable = "Integer";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(UpdateBOL)
            {
                ApplicationArea = All;
                Caption = 'Update BOL';
                ToolTip = 'Update BOL';

                trigger OnAction()
                begin
                    MiracleFixes.UpdateBOLFields();
                end;
            }
        }
    }

    var
        MiracleFixes: Codeunit "Miracle Fixes";
}
