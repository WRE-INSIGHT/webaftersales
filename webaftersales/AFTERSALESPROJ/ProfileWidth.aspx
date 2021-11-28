<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfileWidth.aspx.cs" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" Inherits="webaftersales.AFTERSALESPROJ.ProfileWidth" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile width table</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Profile width table</strong></h3>
        <div class="row">
              <div class="col-sm-6"></div>
            <div class="col-sm-6">
                <div class="input-group">
                    <div class="input-group-addon">
                        FIND
                    </div>
                    <asp:TextBox ID="tboxSearch" CssClass="form-control" runat="server"></asp:TextBox>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="btnsearch" CssClass="btn btn-primary" runat="server" OnClick="btnsearch_Click">search</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <br />
    <div class="panel panel-success" style="background-color: aliceblue;">
        <div class="panel-heading">
            <h3>Input form</h3>
        </div>
        <div class="row">
            <div class="col-sm-3">
                <span>Article No</span><br />
                <asp:TextBox ID="tboxArticleNo" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
               <div class="col-sm-3">
                <span>Color</span><br />
                <asp:TextBox ID="tboxColor" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="col-sm-3">
                <span>Width Inside</span><br />
                <asp:TextBox ID="tboxWidthIn" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="col-sm-3">
                <span>Width Outside</span><br />
                <asp:TextBox ID="tboxWidthOut" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div>
        <br />
        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">add</asp:LinkButton>
    </div>
    <div class="panel panel-success" style="background-color: aliceblue;">
        <div class="panel-heading">
            <h3>Profile list</h3>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" CellPadding="4" GridLines="Both" OnRowCommand="GridView1_RowCommand" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" ForeColor="#333333">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Panel ID="btnpanel1" runat="server">
                                    <asp:LinkButton ID="btndelete" CommandName="mydelete" OnClientClick="return confirm('delete this record?')" runat="server">delete</asp:LinkButton>
                                    |
                                    <asp:LinkButton ID="btnedit" CommandName="myedit" runat="server">edit</asp:LinkButton>
                                </asp:Panel>
                                <asp:Panel ID="btnpanel2" Visible="false" runat="server">
                                    <asp:LinkButton ID="btnsave" CommandName="mysave" runat="server">save</asp:LinkButton>
                                    |
                                        <asp:LinkButton ID="btncancel" CommandName="mycancel" runat="server">cancel</asp:LinkButton>
                                </asp:Panel>
                            </ItemTemplate>

                            <ItemStyle Wrap="False"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ARTICLE#">
                            <ItemTemplate>
                                <asp:Label ID="lblId" Visible="false" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                                <asp:Label ID="lblArticleNo" runat="server" Text='<%# Bind("Article_No") %>'></asp:Label>
                                <asp:TextBox ID="tboxArticleNoEdit" Visible="false" CssClass="form-control" Text='<%# Bind("Article_No") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                           <asp:TemplateField HeaderText="COLOR">
                            <ItemTemplate>
                                <asp:Label ID="lblColor" runat="server" Text='<%# Bind("Color") %>'></asp:Label>
                                <asp:TextBox ID="tboxColorEdit" Visible="false" CssClass="form-control" Text='<%# Bind("Color") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="WIDTH INSIDE">
                            <ItemTemplate>
                                <asp:Label ID="lblInside" runat="server" Text='<%# Bind("Width_In") %>'></asp:Label>
                                <asp:TextBox ID="tboxWidthInEdit" Visible="false" TextMode="Number" CssClass="form-control" Text='<%# Bind("Width_In") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="WIDTH OUTSIDE">
                            <ItemTemplate>
                                <asp:Label ID="lblOutside" runat="server" Text='<%# Bind("Width_Out") %>'></asp:Label>
                                <asp:TextBox ID="tboxWidthOutEdit" Visible="false" TextMode="Number" CssClass="form-control" Text='<%# Bind("Width_Out") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
