<?xml version="1.0"?>
<queryset>

<fullquery name="gl_glossar_portlet">
    <querytext>  
	SELECT 
		cr.item_id as glossar_id, 
		crr.title, 
		crr.description, 
		gl.source_category_id, 
		gl.target_category_id, 
		gl.owner_id, 
		org.name, 
		1 as query_number,
		case 
			when gl.target_category_id is null 
			then 0 
			else 1 end as sort_key  
      	FROM 
		gl_glossars gl, 
		cr_items cr, 
		cr_revisions crr, 
		organizations org  
      	WHERE 
		cr.latest_revision = crr.revision_id 
      		AND crr.revision_id = gl.glossar_id	
     		AND gl.owner_id = org.organization_id
      		AND org.organization_id = :customer_id 
      		UNION
      			SELECT 
				cr.item_id as glossar_id, 
				crr.title, 
				crr.description, 
				gl.source_category_id, 
				gl.target_category_id, 
				gl.owner_id, 
				org.name, 
				2 as query_number,
				case 
				when gl.target_category_id is null 
				then 0 
				else 1 end as sort_key  
		      	FROM 
				gl_glossars gl, 
				cr_items cr, 
				cr_revisions crr, 
				organizations org    
      			WHERE 
				cr.latest_revision = crr.revision_id 
      				AND crr.revision_id = gl.glossar_id	
      				AND gl.owner_id =  org.organization_id
      				AND org.organization_id IN ('$where_etat_ids')
      				ORDER BY query_number asc
    </querytext>
</fullquery>

<fullquery name="get_files_count">
   <querytext>
        select
                count(ci.item_id)
        from
                cr_items ci
        where
                ci.parent_id = :glossar_id
		and ci.content_type != 'gl_glossar_term'		

   </querytext>
</fullquery>

</queryset>