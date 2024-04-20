<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="callin_monitoringReport.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.callin_monitoringReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Aftersales Call-in Monitoring</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Aftersales Call-in Monitoring Report</strong></h3>
    </div>
    <div style="overflow-x: auto">
        <rsweb:ReportViewer ID="rpt1" runat="server" SizeToReportContent="true">
            <LocalReport ReportPath="AFTERSALESPROJ\report\callin_monitoringRPT.rdlc">
            </LocalReport>
        </rsweb:ReportViewer>
    </div>
</asp:Content>
