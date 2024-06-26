﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="servicing_monitoring_report.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.servicing_monitoring_report" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Servicing Calendar</title>
</asp:Content>


<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <div class="container">
        <div class="well">
            <h2 class="text-center">Servicing report monitoring</h2>
        </div>
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:sqlcon %>"
                SelectCommand="Servicing_Monitoring_Stp"
                SelectCommandType="StoredProcedure"
                OnSelecting="SqlDataSource1_Selecting">
                <SelectParameters>
                    <asp:SessionParameter Name="search" SessionField="s_monitoring_search" Type="String" DefaultValue="-" />
                    <asp:SessionParameter Name="sdate" SessionField="s_monitoring_sdate" Type="String" DefaultValue="-" />
                    <asp:SessionParameter Name="edate" SessionField="s_monitoring_edate" Type="String" DefaultValue="-" />
                    <asp:SessionParameter Name="status" SessionField="s_monitoring_status" Type="Int32" DefaultValue="10" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="Panel1" runat="server">
                <div style="overflow-x: auto">
                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="true">
                        <LocalReport ReportPath="AFTERSALESPROJ\report\servicing_monitoring_rpt.rdlc">
                            <DataSources>
                                <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                            </DataSources>
                        </LocalReport>
                    </rsweb:ReportViewer>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
