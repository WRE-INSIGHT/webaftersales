<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="importPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.importPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Import items</title>
      <script>
        function confimmessage() {
            confirm('import selected items?');
        }
        function alerme() {
            alert("data save successfully");
        }
        //function redirectme()
        //{
        //    window.open("frmReport.aspx");
        //}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="page-header">
            <h1>
                <asp:Label ID="Label1" runat="server" Text="KMDI System data"></asp:Label></h1>
        </div>

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" CssClass="table" runat="server" AutoGenerateColumns="False" EmptyDataText="No result found." AllowPaging="True" DataKeyNames="ID" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="cboxselect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="ID" DataField="ID" />
                        <asp:BoundField HeaderText="K#" DataField="KMDI_NO" />
                        <asp:BoundField HeaderText="ITEM#" DataField="ITEM_NO" />
                        <asp:BoundField HeaderText="LOCATION" DataField="LOCATION" />
                    </Columns>
                </asp:GridView>
                <br />
                <br />
                <asp:Button ID="btnimport" Width="100%" CssClass="btn btn-primary" runat="server" OnClick="btnimport_Click" Text="import selected rows" />

            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <br />
        <div>
            <asp:HyperLink ID="HyperLink1" CssClass="btn btn-danger" Width="100%" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="&lt;&lt; back to report"></asp:HyperLink>
        </div>
        <div class="container">
            <div class="alert alert-danger">
                <asp:Label ID="errorlbl" runat="server" Text="Label"></asp:Label>
            </div>
        </div>

        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Page says</h4>
                    </div>
                    <div class="modal-body">
                        <p>modal.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
