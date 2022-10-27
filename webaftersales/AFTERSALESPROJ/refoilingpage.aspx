<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="refoilingpage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.refoilingpage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Re-foiling Proposal</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Re-foiling Proposal</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" runat="server" PostBackUrl="~/AFTERSALESPROJ/addservicing.aspx">back</asp:LinkButton>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <div class="well">
        <h2>
            <strong>
                <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label></strong><br />
            <small>
                <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label></small></h2>
    </div>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="well">
                <div class="row">

                    <div class="col-sm-6">
                        Date<br />
                        <asp:TextBox ID="tboxdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="tboxdate" ValidationGroup="val1" ID="RequiredFieldValidator2" runat="server" ErrorMessage="date is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <br />
                        <asp:Button ID="Button1" ValidationGroup="val1" runat="server" CssClass="btn btn-primary" Text="add" OnClick="Button1_Click" />
                    </div>

                </div>
            </div>

            <br />
            <h2>Table</h2>
            <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">

                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" OnRowCommand="GridView1_RowCommand" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton CssClass="btn btn-success" CommandName="myedit" ID="btnedit" runat="server">edit</asp:LinkButton>
                                <asp:LinkButton CssClass="btn btn-danger" CommandName="mydelete" ID="btndelete" OnClientClick="return confirm('delete this record?');" runat="server">delete</asp:LinkButton>
                                <asp:LinkButton CssClass="btn btn-success" CommandName="mysave" ValidationGroup="valedit" ID="btnsave" Visible="false" runat="server">save</asp:LinkButton>
                                <asp:LinkButton CssClass="btn btn-danger" CommandName="mycancel" ID="btncancel" Visible="false" runat="server">cancel</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="QUOTATION NO.">
                            <ItemTemplate>
                                <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="lblcin" Visible="false" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                                <asp:Label ID="lblsid" Visible="false" runat="server" Text='<%# Bind("SID") %>'></asp:Label>
                                <asp:Label ID="lblmiscellaneous" Visible="false" runat="server" Text='<%# Bind("MISCELLANEOUS") %>'></asp:Label>
                                <asp:Label ID="lblqno" runat="server" Text='<%# Bind("QNO") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                        <asp:TemplateField HeaderText="DATE">
                            <ItemTemplate>
                                <asp:Label ID="lblqdate" runat="server" Text='<%# Bind("QDATE") %>'></asp:Label>
                                <asp:TextBox ID="tboxqdateedit" CssClass="form-control" TextMode="Date" Text='<%# Bind("QDATE") %>' Visible="false" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Visible="false" ControlToValidate="tboxqdateedit" runat="server" ValidationGroup="valedit" ErrorMessage="date is required" ForeColor="Red"></asp:RequiredFieldValidator>
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="LOCK">
                            <ItemTemplate>
                                <asp:Label ID="lblLock" Visible="true" runat="server" Text='<%# Eval("LOCK").ToString() == "0" ? "no" : "yes"  %>'></asp:Label>
                                <asp:DropDownList ID="ddlLock" Visible="false" CssClass="form-control" Text='<%# Bind("LOCK") %>' runat="server">
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton CssClass="" ID="LinkButton1" CommandName="myitem" runat="server">items</asp:LinkButton>
                                |
                                <asp:LinkButton CssClass="" ID="btnviewreport" CommandName="viewreport" runat="server">view report</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                    <RowStyle Wrap="false" ForeColor="#000066" />
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle Wrap="false" BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>
                <asp:ValidationSummary ID="ValidationSummary2" ValidationGroup="valedit" CssClass="alert alert-danger" runat="server" />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
