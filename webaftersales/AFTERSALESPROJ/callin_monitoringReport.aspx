<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="callin_monitoringReport.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.callin_monitoringReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Aftersales Call-in Monitoring</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
      <div class="well">
        <h3><strong>Aftersales Call-in Monitoring Report</strong></h3>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" BackColor="White" Height="800px" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        <LocalReport ReportPath="AFTERSALESPROJ\report\callin_monitoringRPT.rdlc">
        </LocalReport>
    </rsweb:ReportViewer>
</asp:Content>
