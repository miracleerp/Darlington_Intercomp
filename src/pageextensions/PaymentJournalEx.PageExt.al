pageextension 50127 "PaymentJournalEx" extends "Payment Journal"
{
    var
        myInt: Integer;

    trigger OnAfterGetCurrRecord()
    var
        vendLedgerEntry: record "Vendor Ledger Entry";
    begin
        vendLedgerEntry.SetFilter("Document No.", '=%1', rec."Applies-to Doc. No.");
        if vendLedgerEntry.FindSet then begin
            rec.Validate("External Document No.", vendLedgerEntry."External Document No.");
            rec.Modify;
        end;
    end;
}
