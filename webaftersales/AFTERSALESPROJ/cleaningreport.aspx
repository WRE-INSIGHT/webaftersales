<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="cleaningreport.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.cleaningreport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cleaning Form</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Cleaning Proposal Form</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-default" OnClick="LinkButton1_Click">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SELECT [ID], [IID], [LOCATION], [AREA], [UNITPRICE], [QTY], [TOTALAMOUNT] FROM [CLEANINGITEM] WHERE ([IID] = @IID)">
        <SelectParameters>
            <asp:SessionParameter Name="IID" SessionField="cleaningid" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    Dear<asp:TextBox ID="tboxnote1" runat="server" ></asp:TextBox><br />
    Thank you for letting us serve you. Please find herewith our quotation for the
    <asp:TextBox ID="tboxnote2" Width="300"  runat="server"></asp:TextBox>
    for your requirements on your residence.<br /><br />
    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-primary" OnClick="LinkButton2_Click">refresh report</asp:LinkButton><br />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="800px" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        <LocalReport ReportPath="AFTERSALESPROJ\report\cleaningRPT.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" Width="200" runat="server" OnClick="LinkButton3_Click">PREPARED BY</asp:LinkButton><br />
    <asp:LinkButton ID="LinkButton4" CssClass="btn btn-default" Width="200" runat="server" OnClick="LinkButton4_Click">NOTED BY</asp:LinkButton>
</asp:Content>

