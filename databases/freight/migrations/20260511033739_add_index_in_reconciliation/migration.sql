-- CreateIndex
CREATE INDEX "reconciliation_data_invoice_id_index" ON "ReconciliationData"("invoiceId");

-- CreateIndex
CREATE INDEX "reconciliation_data_shipment_reference_id_index" ON "ReconciliationData"("shipmentReferenceId");

-- CreateIndex
CREATE INDEX "reconciliation_history_invoice_id_index" ON "ReconciliationHistory"("invoiceId");
