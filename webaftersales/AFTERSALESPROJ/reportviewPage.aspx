<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="reportviewPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.reportviewPage" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="scripts/sign.js"></script>
    <script>
        $(document).ready(function () {
            $('#myCanvas').sign({
                resetButton: $('#resetSign'),
                lineWidth: 5
            });
        });
    </script>
    <style>
        #myCanvas {
            border: 4px solid #444;
            border-radius: 1px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="page-header">
            <h2>
                <asp:Label ID="Label1" runat="server" Text="Report Viewer"></asp:Label></h2>

            <div class="navbar-right">
                <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" runat="server" OnClick="LinkButton3_Click">back</asp:LinkButton>
            </div>
        </div>
        <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" SelectCommand="
               select kno,itemno,location,specification,reportid,[description],assessment from tblassessment as a
left join reporttb as b
on a.reportid = b.id where (b.[SID] = @SID)">
            <SelectParameters>
                <asp:SessionParameter Name="SID" SessionField="SID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" SelectCommand="SELECT * FROM [SERVICINGTB] WHERE ([ID] = @ID)">
            <SelectParameters>
                <asp:SessionParameter Name="ID" SessionField="SID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <rsweb:ReportViewer CssClass="report" BorderStyle="Solid" Width="100%" Height="800"
                    ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" OnReportRefresh="ReportViewer1_ReportRefresh">
                    <LocalReport ReportPath="AFTERSALESPROJ\report\RPTassessment.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet1" />
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource3" Name="DataSet2" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <asp:Panel ID="Panel1" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">Sign Signature</div>
                <div class="panel-body">
                    <asp:LinkButton ID="LinkButton1" runat="server" Width="300" CssClass="btn btn-primary" OnClick="LinkButton1_Click">Inspected and Assessed by</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" Width="300" CssClass="btn btn-primary" OnClick="LinkButton2_Click">Assessment Monitored and Accepted by</asp:LinkButton>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>


