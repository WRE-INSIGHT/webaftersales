<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="manageAccountsPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.manageAccountsPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <script type="text/javascript">
        function fncsave() {
          <%--  document.getElementById('<%= LinkButton3.ClientID %>').click();--%>
            document.getElementById('modalbtn').click();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="page-header">
        <h2><small>Manage Accounts</small></h2>
    </div>


    <div class="panel panel-default">
        <div class="panel-heading">
            For verification
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView CssClass="table table-hover" GridLines="None" ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand" DataKeyNames="ID">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField HeaderText="lastname" DataField="lastname" />
                            <asp:BoundField HeaderText="firstname" DataField="firstname" />
                            <asp:BoundField HeaderText="pid" DataField="pid" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton CssClass="btn btn-success" ID="LinkButton2" CommandName="myverification" runat="server"><span class="glyphicon glyphicon-check"></span>verify</asp:LinkButton>
                                    <asp:LinkButton CssClass="btn btn-danger" ID="LinkButton1" CommandName="mycancel" OnClientClick="return confirm('Are you sure you want to delete this record?');" ToolTip="Cancel this account?" runat="server"><span class="glyphicon glyphicon-minus-sign"></span>cancel</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <input type='hidden' id='modalbtn' name='modalbtn' data-toggle="modal" data-target="#myModal" data-backdrop='static' data-keyboard='false' />
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div id="myModal" class="modal fade" role="form">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            <h4 class="modal-title">Modal Header</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p>Some text in the modal.</p>


                                            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                                            <asp:DropDownList ID="personneldl" CssClass="form-control" Height="40" runat="server"></asp:DropDownList>
                                            <asp:LinkButton ID="LinkButton3" OnClick="savebtnclick" runat="server">LinkButton</asp:LinkButton>


                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    
    <div class="panel panel-primary">
        <div class="panel-heading">
            User Accounts
        </div>
        <div class="panel-body">
            <asp:GridView ID="GridView2" CssClass="table table-stripped" GridLines="None" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField HeaderText="Lastname" DataField="LASTNAME" />
                    <asp:BoundField HeaderText="FIRSTNAME" DataField="FIRSTNAME" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
