<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="cleaningreport.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.cleaningreport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Re-cleaning Form</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Re-cleaning Proposal Form</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-default" OnClick="LinkButton1_Click">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SELECT [Id],[Cleaning_Id],[Item_Description],[Width],[Height],[AREA],[Qty],[In_Out],[Price] from [Cleaning_Item_Tbl] WHERE ([Cleaning_Id] = @IID)">
        <SelectParameters>
            <asp:SessionParameter Name="IID" SessionField="cleaningid" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div style="overflow-x: auto">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="true">
            <LocalReport ReportPath="AFTERSALESPROJ\report\cleaningRPT.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
    </div>
    <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" Width="200" runat="server" OnClick="LinkButton3_Click">PREPARED BY</asp:LinkButton><br />
    <asp:LinkButton ID="LinkButton4" CssClass="btn btn-default" Width="200" runat="server" OnClick="LinkButton4_Click">NOTED BY</asp:LinkButton>
</asp:Content>

