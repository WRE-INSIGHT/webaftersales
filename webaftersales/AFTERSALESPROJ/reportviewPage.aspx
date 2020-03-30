<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="reportviewPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.reportviewPage" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        table{
            
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
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
                <rsweb:ReportViewer CssClass="report" Width="100%" ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" OnReportRefresh="ReportViewer1_ReportRefresh">
                    <LocalReport ReportPath="AFTERSALESPROJ\report\RPTassessment.rdlc">
                           <DataSources>
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet1" />
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource3" Name="DataSet2" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
            </ContentTemplate>
        </asp:UpdatePanel>     
    </div>
</asp:Content>


