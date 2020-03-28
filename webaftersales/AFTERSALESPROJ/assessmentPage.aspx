<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="assessmentPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.assessmentPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Assessment</title>
  
    <style>
        .modal-header, h4, .close {
            background-color: #5cb85c;
            color: white !important;
            text-align: center;
            font-size: 30px;
        }

        .modal-footer {
            background-color: #f9f9f9;
        }
    </style>
    <style>
        .modal-header, h4, .close {
            background-color: #5cb85c;
            color: white !important;
            text-align: center;
            font-size: 30px;
        }

        .modal-footer {
            background-color: #f9f9f9;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="page-header">
            <h1>
                <asp:Label ID="lblkno" runat="server" Text="Label"></asp:Label><small>
                    <asp:Label ID="lbllocation" runat="server" Text="Label"></asp:Label></small></h1>
        </div>
    </div>
    <div class="container">
        <div class="page-header">
            <h3>Cutting List</h3>
            <div class="navbar-right">
                <asp:HyperLink ID="HyperLink1" Width="160" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="&lt;&lt; back to report"></asp:HyperLink>
            </div>
        </div>

        <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>


                <asp:GridView ID="GridView1" CssClass="table" runat="server"
                    AutoGenerateColumns="False" EmptyDataText="No result found."
                    AllowPaging="True" DataKeyNames="ID"
                    OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="cboxselect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="STOCKNO" DataField="STOCKNO" />
                        <asp:BoundField HeaderText="HEADER" DataField="HEADER" />
                        <asp:BoundField HeaderText="COSTHEAD" DataField="COSTHEAD" />
                        <asp:BoundField HeaderText="TYPECOLOR" DataField="TYPECOLOR" />
                        <asp:BoundField HeaderText="ARTICLENO" DataField="ARTICLENO" />
                        <asp:BoundField HeaderText="DESCRIPTION" DataField="DESCRIPTION" />
                    </Columns>
                </asp:GridView>
                <asp:Button ID="importbtn" CssClass="btn btn-default" runat="server" Text="Import selected items" OnClick="importbtn_Click" />

                <div class="page-header">
                    <h3>Assessment</h3>
                </div>

                <div class="container">
                    <asp:GridView ID="GridView2" CssClass="table" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" OnPageIndexChanging="GridView2_PageIndexChanging" OnRowDataBound="GridView2_RowDataBound" CellPadding="4" ForeColor="#333333" GridLines="None">
                        
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" />
                            <asp:BoundField DataField="REPORTID" HeaderText="REPORTID" SortExpression="REPORTID" />
                            <asp:BoundField DataField="STOCKNO" HeaderText="STOCKNO" SortExpression="STOCKNO" />
                            <asp:BoundField DataField="DESCRIPTION" HeaderText="DESCRIPTION" SortExpression="DESCRIPTION" />
                            <asp:BoundField DataField="ASSESSMENT" HeaderText="ASSESSMENT" SortExpression="ASSESSMENT" />
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" DeleteCommand="DELETE FROM [TBLassessment] WHERE [ID] = @ID" InsertCommand="INSERT INTO [TBLassessment] ([ID], [REPORTID], [STOCKNO], [DESCRIPTION], [ASSESSMENT]) VALUES (@ID, @REPORTID, @STOCKNO, @DESCRIPTION, @ASSESSMENT)" SelectCommand="SELECT * FROM [TBLassessment] WHERE ([REPORTID] = @REPORTID)" UpdateCommand="UPDATE [TBLassessment] SET [REPORTID] = @REPORTID, [STOCKNO] = @STOCKNO, [DESCRIPTION] = @DESCRIPTION, [ASSESSMENT] = @ASSESSMENT WHERE [ID] = @ID">
                        <DeleteParameters>
                            <asp:Parameter Name="ID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="ID" Type="Int32" />
                            <asp:Parameter Name="REPORTID" Type="Int32" />
                            <asp:Parameter Name="STOCKNO" Type="Int32" />
                            <asp:Parameter Name="DESCRIPTION" Type="String" />
                            <asp:Parameter Name="ASSESSMENT" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:SessionParameter Name="REPORTID" SessionField="reportID" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="REPORTID" Type="Int32" />
                            <asp:Parameter Name="STOCKNO" Type="Int32" />
                            <asp:Parameter Name="DESCRIPTION" Type="String" />
                            <asp:Parameter Name="ASSESSMENT" Type="String" />
                            <asp:Parameter Name="ID" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
