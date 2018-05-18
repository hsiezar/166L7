CREATE INDEX partn_nyc
ON part_nyc
USING BTREE
(part_number);

CREATE INDEX partn_sfo
ON part_sfo
USING BTREE
(part_number);

CREATE INDEX supId
ON supplier
USING BTREE 
(supplier_id);

CREATE INDEX sfo_sup
ON part_sfo
USING BTREE
(supplier);

CREATE INDEX nyc_sup
ON part_nyc
USING BTREE
(supplier);
