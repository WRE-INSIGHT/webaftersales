<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="tripticketreport.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.tripticketreport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trip Ticket</title>
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="well">
        <h3><strong>Trip Ticket</strong></h3>
        <div class="input-group">
            <div class="input-group-addon">
                Date
            </div>
            <asp:TextBox ID="tboxdate" CssClass="form-control" TextMode="Date" ValidationGroup="val1" runat="server"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="LinkButton4" CssClass="btn btn-default" ValidationGroup="val1" runat="server" OnClick="LinkButton4_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>

    </div>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Visible="false" ControlToValidate="tboxdate" ErrorMessage="please set a date!"></asp:RequiredFieldValidator>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server">
        <SelectParameters>
            <asp:ControlParameter ControlID="tboxdate" Name="datekey" PropertyName="Text" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    <rsweb:ReportViewer ID="ReportViewer1" width="100%" height="800px" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        <LocalReport ReportPath="AFTERSALESPROJ\report\tripticketRPT.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
            </DataSources>
        </LocalReport>

    </rsweb:ReportViewer>
    </asp:Content>
