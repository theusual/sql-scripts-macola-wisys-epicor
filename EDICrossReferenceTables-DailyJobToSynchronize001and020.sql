 --EDI Ship To Cross Reference - FOR GL Codes
BEGIN
  Insert Into [020].[dbo].[edcshtfl_sql] (location, cust_num, mac_location, child_location, child_cust_num, default_xref_pkg_code, lit_default_loc_1, lit_default_loc_3, misc_num_info_1, misc_num_info_2, misc_num_info_3, misc_num_info_4, misc_num_info_5)
 
      Select Distinct location, cust_num, mac_location, child_location, child_cust_num, default_xref_pkg_code, lit_default_loc_1, lit_default_loc_3, misc_num_info_1, misc_num_info_2, misc_num_info_3, misc_num_info_4, misc_num_info_5
      From [001].[dbo].[edcshtfl_sql]
      WHERE not(location+cust_num IN (SELECT location+cust_num from [020].[dbo].[edcshtfl_sql]))
END

 --EDI Carrier Cross Reference - For SCAC codes
BEGIN
   Insert Into [020].[dbo].[edcshvfl_sql] (code, cust_num, mac_ship_via, pay_type, carrier, id_scac_code, transport_type,misc_info_1, misc_num_info_1, misc_num_info_2, misc_info_3, misc_num_info_4, misc_num_info_5)
 
      Select Distinct code, cust_num, mac_ship_via, pay_type, carrier, id_scac_code, transport_type,misc_info_1, misc_num_info_1, misc_num_info_2, misc_info_3, misc_num_info_4, misc_num_info_5
      From [001].[dbo].[edcshvfl_sql]
      WHERE not(mac_ship_via IN (SELECT mac_ship_via from [020].[dbo].[edcshvfl_sql]))
END

 --EDI Customer Item Cross Reference - For Cus Item #
BEGIN
   Insert Into [020].[dbo].[edcitmfl_sql] (edi_item_num, cust_num, mac_item_num, upc_num, upn_num, lit_default_bin_1_1,tp_item_num,ib_um, ib_um_conv_type, ib_um_factor, ob_um, ob_um_conv_type, ob_um_factor, sales_um, um_round, price_basis, inner_outer, explode, item_size, misc_num_info_1, misc_num_info_2, misc_num_info_3, misc_num_info_4, misc_num_info_5, taxable_flag_1, taxable_flag_2, taxable_flag_3, extra_10, extra_11, extra_12, extra_13)
 
      Select Distinct edi_item_num, cust_num, mac_item_num, upc_num, upn_num, lit_default_bin_1_1,tp_item_num,ib_um, ib_um_conv_type, ib_um_factor, ob_um, ob_um_conv_type, ob_um_factor, sales_um, um_round, price_basis, inner_outer, explode, item_size, misc_num_info_1, misc_num_info_2, misc_num_info_3, misc_num_info_4, misc_num_info_5, taxable_flag_1, taxable_flag_2, taxable_flag_3, extra_10, extra_11, extra_12, extra_13
      From [001].[dbo].[edcitmfl_sql]
      WHERE not(edi_item_num IN (SELECT edi_item_num from [020].[dbo].[edcitmfl_sql]))
END
 
  --OE Customer Item Maintenace - For Pricing
BEGIN
    Insert Into [020].[dbo].[oecusitm_sql] (cus_no, item_no, cus_item_no, uom, item_price, discount)
 
      Select Distinct cus_no, item_no, cus_item_no, uom, item_price, discount
      From [001].[dbo].[oecusitm_sql]
      WHERE not((item_no + cus_no) IN (SELECT (item_no + cus_no) from [020].[dbo].[oecusitm_sql]))
END

 --Macola Shipping Cross Reference - For mac_ship_via code
BEGIN
   Insert Into [020].[dbo].[sycdefil_sql]  (cd_type, sy_code, code_desc, msc_mn_no, msc_sb_no, msc_dp_no, frg_mn_no, frg_sb_no, frg_dp_no, carrier_cd, manifest_mode_cd, manifest_ins_perc, humres_id)
 
      Select Distinct cd_type, sy_code, code_desc, msc_mn_no, msc_sb_no, msc_dp_no, frg_mn_no, frg_sb_no, frg_dp_no, carrier_cd, manifest_mode_cd, manifest_ins_perc, humres_id
      From [001].[dbo].[sycdefil_sql] 
      WHERE not(sy_code IN (SELECT sy_code from [020].[dbo].[sycdefil_sql]  WHERE cd_type = 'V' )) AND cd_type = 'V'
END