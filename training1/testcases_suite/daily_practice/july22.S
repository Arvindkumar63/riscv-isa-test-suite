// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        22-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  structural hazards 
// Description:  Verify that structural hazards occur when multiple instructions
//               access the same resource (e.g., memory) at the same clock cycle.
//
// ===========================================================
RVTEST_BEGIN

RVTEST_CODE_BEGIN

li gp, 3

test1:


RVTEST_CODE_END
RVTEST_END
.data

RVTEST_DATA_BEGIN

RVTEST_DATA_END
