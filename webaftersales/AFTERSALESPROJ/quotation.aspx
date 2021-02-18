<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="quotation.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotation" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation Ctrl #</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Quotation Control #</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" runat="server" OnClick="LinkButton3_Click">back</asp:LinkButton>
        </div>
    </div>
    <h2>
        <strong>
            <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label></strong><br />
        <small>
            <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label></small></h2>
    <br />

    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>





    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>

            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-danger" runat="server" OnClick="LinkButton2_Click">requested proposal</asp:LinkButton>

            <asp:Panel ID="Panel2" ScrollBars="Auto" runat="server">

                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" OnRowCommand="GridView1_RowCommand" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton7"  OnClientClick="return confirm('delete this record?')" Visible='<%# Eval("LOCK").ToString() == "1" ? false : true %>' runat="server" CommandName="myrevise">Revise</asp:LinkButton>
                                <asp:LinkButton ID="editlink" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                <asp:LinkButton ID="deletelink" CommandName="mydelete" OnClientClick="return confirm('delete this record?')" runat="server">Delete</asp:LinkButton>
                                <asp:LinkButton ID="updatelink" Visible="false" CommandName="mysave" runat="server">Update</asp:LinkButton>
                                <asp:LinkButton ID="cancellink" Visible="false"  CommandName="mycancel" runat="server">Cancel</asp:LinkButton><br />
                                <asp:ValidationSummary ID="editvalsummary" ValidationGroup="editval" Visible="false" CssClass="alert alert-danger" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="items" runat="server" CommandName="myitem">Items</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="report">Report</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="btnpdf" runat="server" CommandName="pdffile">PDF file</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ASE #">
                            <ItemTemplate>
                                <asp:Label ID="idlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="asenolbl" runat="server" Text='<%# Bind("ASENO") %>'></asp:Label>
                                <asp:TextBox ID="editasenotbox" Visible="false" Text='<%# Eval("ASENO") %>' placeholder="ASE" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DATE">
                            <ItemTemplate>
                                <asp:Label ID="datelbl" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                                <asp:RequiredFieldValidator ID="editRequiredFieldValidator1" runat="server" ErrorMessage="Date is required!"
                                    ControlToValidate="editdatetbox" ValidationGroup="editval" ForeColor="Red">*</asp:RequiredFieldValidator>
                                <asp:TextBox ID="editdatetbox" Visible="false" TextMode="Date" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="STATUS">
                            <ItemTemplate>
                                <asp:Label ID="acceptedlbl" runat="server" Text='<%# Eval("ACCEPTED").ToString() == "" ? "Pending" : Eval("ACCEPTED") %>'></asp:Label>
                                <asp:TextBox ID="editaccepteddatetbox" Visible="false" TextMode="Date" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="OTHER CHARGER">
                            <ItemTemplate>
                                <asp:Label ID="otherlbl" runat="server" Text='<%# Bind("[OTHER CHARGES]") %>'></asp:Label>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PARTICULAR">
                            <ItemTemplate>
                                <asp:Label ID="particularlbl" runat="server" Text='<%# Bind("PARTICULAR") %>'></asp:Label>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="NET PRICE">
                            <ItemTemplate>
                                <asp:Label ID="netpricelbl" runat="server" Text='<%# Bind("NETPRICE") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ACTUAL PRICE">
                            <ItemTemplate>
                                <asp:Label ID="actualpricelbl" runat="server" Text='<%# Bind("[ACTUAL PRICE]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                           <asp:TemplateField HeaderText="VAT AMOUNT">
                            <ItemTemplate>
                                <asp:Label ID="vatamountlbl" runat="server" Text='<%# Bind("[VAT_AMOUNT]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle Wrap="False" ForeColor="#000066" />
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle Wrap="False" BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" ForeColor="#000066" HorizontalAlign="Left" BackColor="White" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Empty Table!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>

            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>


    <br />
    <div class="panel panel-default">
        <div class="panel-body">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="Label4" Font-Size="X-Large" runat="server" Text="manual input"></asp:Label><br />
                    <div class="row">
                        <div class="col-sm-6">
                            Quotation date
                               <asp:CompareValidator ID="CompareValidator1" ControlToValidate="datetbox" Type="Date" Operator="DataTypeCheck"
                                   ValidationGroup="newval" runat="server" ErrorMessage="Invalid date format!" ForeColor="Red">*</asp:CompareValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Date is required!"
                                ControlToValidate="datetbox" ValidationGroup="newval" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                            <asp:TextBox ID="datetbox" TextMode="Date" placeholder="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                            ASE#<br />
                            <asp:TextBox ID="asetbox" placeholder="ASE" CssClass="form-control" runat="server"></asp:TextBox>
                            
                            <br />
                        </div>
                        <div class="col-sm-6">
                            Other charges<br />
                            <asp:TextBox ID="othertbox" placeholder="Other charges" CssClass="form-control" runat="server"></asp:TextBox><br />
                            Particular<br />
                            <asp:TextBox ID="particulartbox" placeholder="Particular" CssClass="form-control" runat="server"></asp:TextBox><br />
                        </div>

                    </div>



                    <asp:Button ID="newbtn" OnClick="newbtn_click" CssClass="btn btn-primary" ValidationGroup="newval" runat="server" Text="add" />
                    <asp:ValidationSummary ID="valsummary" ValidationGroup="newval" CssClass="alert alert-danger" runat="server" />

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
