<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="Servicing_Report_SummaryRPT.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.Servicing_Report_SummaryRPT" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Assessment Summary Report</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2 class="text-center">Assessment Summary Report</h2>
            <span class="pull-right">
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
            </span>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon_server1_asdb %>" SelectCommand="Servicing_Report_Summary_Stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource1_Selecting">
            <SelectParameters>
                <asp:Parameter Name="Command" Type="String" DefaultValue="Report" />
                <asp:SessionParameter Name="CIN" SessionField="lblCIN" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
              <rsweb:ReportViewer ID="ReportViewer2" runat="server" SizeToReportContent="true" OnReportRefresh="ReportViewer1_ReportRefresh">
                    <LocalReport ReportPath="AFTERSALESPROJ\report\ServicingReportSummaryRPT.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
        </asp:Panel>
    </div>
</asp:Content>
