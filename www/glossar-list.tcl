# packages/glossar-portlet/www/glossar-list.tcl

ad_page_contract {
    
    Creates a list with all Glossars for Customer,
    direct and indirect ones from Etat
  
    
    @author Bjoern Kiesbye (bjoern_kiesbye@web.de)
    @creation-date 2005-07-29
    @arch-tag: a7a412af-2b23-46f6-9414-ca3c0b7df8b4
    @cvs-id $Id$
} {
    {gl_format "normal"}
    {gl_orderby ""}
    {gl_customer_id ""}
} -properties {
    owner_ids
    gl_format
    gl_orderby
    gl_customer_id
} -validate {
} -errors {
}


set owner_ids [list]
set community_id [dotlrn_community::get_community_id_from_url]
set customer_id [application_data_link::get_linked   -from_object_id $community_id   -to_object_type "organization" ]

ad_return_complaint 1 "$customer_id"

ns_log notice "custommer_id(s) $customer_id"
lappend owner_ids $customer_id

db_foreach get_etat_ids {SELECT object_id_one FROM acs_rels WHERE rel_type = 'contact_rels_etat' AND object_id_two = :customer_id} {

    lappend owner_ids $object_id_one
}

ns_log notice "owner_ids $owner_ids"